import 'dart:convert';
import 'package:allo_service/models/client_model.dart';
import 'package:allo_service/services/auth_service.dart';
import 'package:allo_service/services/constants.dart';
import 'package:http/http.dart' as http;

class ApiServiceClient {

// Méthode pour récupérer les services et prestataires
  static Future<ApiResponse> fetchServices() async {
     final AuthService _authService = AuthService();
      var token = await _authService.getToken();
     final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/client/services'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ApiResponse.fromJson(data); 

    } else {
     throw Exception('Erreur lors de la récupération des données');
    }
      
    
  }
}
