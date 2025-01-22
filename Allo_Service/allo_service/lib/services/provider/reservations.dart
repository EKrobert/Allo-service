import 'dart:convert';
import 'package:allo_service/services/auth_service.dart';
import 'package:http/http.dart' as http;
import '/services/constants.dart';

class Api {
  // Récupérer les réservations
  
  static Future<Map<String, dynamic>>  fetchReservations() async {
    final AuthService _authService = AuthService();
    var token = await _authService.getToken();
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/provider/reservations'), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erreur lors de la récupération des réservations');
    }
  }

 // Méthode pour récupérer les détails d'une réservation
  static Future<Map<String, dynamic>> fetchReservationDetails(String reservationId) async {
    final AuthService _authService = AuthService();
    var token = await _authService.getToken();
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/provider/reservation/$reservationId'),
    headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Échec du chargement des détails de la réservation');
    }
  }


  static Future<void> validateReservation(String reservationId) async {
  final AuthService _authService = AuthService();
  var token = await _authService.getToken();

  final response = await http.post(
    Uri.parse('${ApiConstants.baseUrl}/provider/reservation/$reservationId/validate'),
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception('Échec de la validation de la réservation. Statut: ${response.statusCode}');
  }
}

}
