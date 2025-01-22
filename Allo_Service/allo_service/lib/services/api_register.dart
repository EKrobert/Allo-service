import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';

class ApiService {

 static Future<Map<String, dynamic>> registerUser(Map<String, dynamic> userData) async {
  final url = Uri.parse('${ApiConstants.baseUrl}/register');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(userData),
  );

  final responseBody = jsonDecode(response.body);

  if (response.statusCode == 200) {
    // Réponse de succès
    return responseBody;
  } else if (response.statusCode == 400) {
    // Erreur de validation
    final errors = responseBody['errors'] as Map<String, dynamic>;
    final errorMessages = errors.entries.map((entry) {
      return "${entry.key}: ${entry.value.join(', ')}";
    }).join('\n');
    throw Exception(errorMessages);
  } else {
    // Autres erreurs
    throw Exception(responseBody['message'] ?? "Une erreur s'est produite");
  }
}


static Future<Map<String, dynamic>> login(Map<String, String> credentials) async {
    final response = await http.post(
      Uri.parse("${ApiConstants.baseUrl}/login"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(credentials),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Erreur: ${response.body}");
    }
  }


}
