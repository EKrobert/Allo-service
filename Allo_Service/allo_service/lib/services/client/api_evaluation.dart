import 'dart:convert';
import 'package:allo_service/models/evaluation_model.dart';
import 'package:allo_service/services/auth_service.dart';
import 'package:allo_service/services/constants.dart';
import 'package:http/http.dart' as http;

class ApiEvaluation {
  static Future<bool> submitEvaluation(Evaluation evaluation) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/client/evaluations');
    final AuthService _authService = AuthService();
    var token = await _authService.getToken();
    print(evaluation);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(evaluation.toJson()), // Convertir l'objet en JSON
      );

      if (response.statusCode == 201) {
        print('Évaluation enregistrée avec succès');
        return true; // Retourne true en cas de succès
      } else {
        print('Erreur lors de l\'enregistrement de l\'évaluation: ${response.statusCode}');
        return false; // Retourne false en cas d'échec
      }
    } catch (e) {
      print('Erreur lors de la requête HTTP: $e');
      return false; // Retourne false en cas d'exception
    }
  }
}
