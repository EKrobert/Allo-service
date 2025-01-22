import 'dart:convert';

import 'package:allo_service/services/auth_service.dart';
import 'package:allo_service/services/constants.dart';
import 'package:http/http.dart' as http;

class ApiReservations {
  static Future<Map<String, dynamic>> fetchReservations() async {
    final AuthService _authService = AuthService();
    var token = await _authService.getToken();

    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/client/reservations'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Échec du chargement des réservations');
    }
  }

// Créer une réservation
  static Future<Map<String, dynamic>> createReservation({
    required int prestataireId,
    required int serviceId,
    required String reservationDate,
    required String adresse,
  }) async {
    final AuthService _authService = AuthService();
    var token = await _authService.getToken();

    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/client/reservation'), // Endpoint de l'API
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'prestataire_id': prestataireId,
        'service_id': serviceId,
        'reservation_date': reservationDate,
        'adresse': adresse,
      }),
    );

    if (response.statusCode == 201) {
      // Réservation créée avec succès
      return json.decode(response.body);
    } else {
      // Gestion des erreurs
      throw Exception('Échec de la création de la réservation: ${response.body}');
    }
  }


static Future<Map<String, dynamic>> fetchReservationDetails(String reservationId) async {
    final AuthService _authService = AuthService();
    var token = await _authService.getToken();

    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/client/reservation/$reservationId'), // Endpoint côté client
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Convertir la réponse JSON en Map
      return json.decode(response.body);
    } else {
      throw Exception('Échec du chargement des détails de la réservation');
    }
  }


}

