import 'dart:convert';
import 'package:allo_service/models/subscribeservice_model.dart';
import 'package:allo_service/services/auth_service.dart';
import 'package:allo_service/services/constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // static Future<List<dynamic>> fetchServices() async {
  //   final AuthService _authService = AuthService();
  //   var token = await _authService.getToken();
  //   final response = await http.get(
  //     Uri.parse('${ApiConstants.baseUrl}/provider/services'),
  //     headers: {
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     return json.decode(response.body)['data'];
  //   } else {
  //     throw Exception('Erreur lors de la récupération des services');
  //   }
  // }

static Future<List<Map<String, dynamic>>> fetchServices() async {
  final AuthService _authService = AuthService();
  var token = await _authService.getToken();

  final response = await http.get(
    Uri.parse('${ApiConstants.baseUrl}/provider/services'),
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    // Extraire la liste des services de la clé "data"
    if (jsonResponse.containsKey('data') && jsonResponse['data'] is List) {
      return List<Map<String, dynamic>>.from(jsonResponse['data']);
    } else {
      throw Exception('La structure de la réponse est incorrecte');
    }
  } else {
    throw Exception('Erreur lors de la récupération des services: ${response.statusCode}');
  }
}


  static Future<void> subscribeToService(int serviceId, double price) async {
    final AuthService _authService = AuthService();
    var token = await _authService.getToken();

    final response = await http.post(
      Uri.parse(
          '${ApiConstants.baseUrl}/provider/add/service'), // Remplacez par votre endpoint
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'service_id': serviceId,
        'prix': price,
      }),
    );

    if (response.statusCode == 200) {
      // Succès
      print('Service ajouté avec succès');
    } else {
      // Gestion des erreurs
      final errorResponse = json.decode(response.body);
      throw Exception(
          errorResponse['message'] ?? 'Échec de l\'abonnement au service');
    }
  }

  static Future<List<SubscribedService>> getSubscribedServices() async {
    final AuthService _authService = AuthService();
    var token = await _authService.getToken();

    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/provider/my/services'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['services'];
      return data
          .map((service) => SubscribedService.fromJson(service))
          .toList();
    } else {
      throw Exception('Échec du chargement des services');
    }
  }

  static Future<void> updateServicePrice(int serviceId, double price) async {
    final AuthService _authService = AuthService();
    var token = await _authService.getToken();

    final response = await http.put(
      Uri.parse(
          '${ApiConstants.baseUrl}/provider/services/$serviceId/update-price'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'prix': price,
      }),
    );

    if (response.statusCode == 200) {
      print('Prix mis à jour avec succès');
    } else {
      throw Exception('Échec de la mise à jour du prix');
    }
  }
}
