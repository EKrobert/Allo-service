import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:allo_service/services/auth_service.dart';
import 'package:allo_service/services/constants.dart';

class ApiAddService {
  // Méthode pour créer un service
  static Future<Map<String, dynamic>> createService(String name,
      {String? description}) async {
    final AuthService _authService = AuthService();
    var token = await _authService.getToken();

    final url = Uri.parse('${ApiConstants.baseUrl}/provider/create/service');

    final body = jsonEncode({
      'name': name,
      'description': description ?? '', // Si description est null, on envoie une chaîne vide
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      if (response.statusCode == 201) {
        // Succès : Service créé
        return {
          'success': true,
          'data': jsonDecode(response.body),
        };
      } else if (response.statusCode == 422) {
        // Erreur de validation
        return {
          'success': false,
          'errors': jsonDecode(response.body)['errors'],
        };
      } else {
        // Autre erreur
        return {
          'success': false,
          'message': 'Erreur: ${response.body}',
        };
      }
    } catch (e) {
      // Erreur de connexion ou autre
      return {
        'success': false,
        'message': 'Erreur: $e',
      };
    }
  }
}