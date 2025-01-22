import 'dart:convert';
import 'package:allo_service/services/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _baseUrl = ApiConstants.baseUrl;
  Future<String?> getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tokenJson = localStorage.getString('token');
    if (tokenJson != null) {
      return jsonDecode(tokenJson)['token'];
    }
    return null;
  }

  Future<void> saveToken(String token) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.setString('token', jsonEncode({'token': token}));
  }

  Future<void> saveUserInfo(Map<String, dynamic> userData) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.setString('userInfo', jsonEncode(userData));
  }

  //user info
  Future<Map<String, dynamic>?> getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userInfoJson = localStorage.getString('userInfo');
    if (userInfoJson != null) {
      return jsonDecode(userInfoJson);
    }
    return null;
  }

  Future<void> clearToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.remove('token');
  }

  Future<http.Response> auth(Map<String, dynamic> data, String apiURL) async {
    var fullUrl = Uri.parse(_baseUrl + apiURL);
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  Future<http.Response> getData(String apiURL) async {
    var fullUrl = Uri.parse(_baseUrl + apiURL);
    var token = await getToken();
    return await http.get(
      fullUrl,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<http.Response> postData(
      Map<String, dynamic> data, String apiURL) async {
    var fullUrl = Uri.parse(_baseUrl + apiURL);
    var token = await getToken();
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<http.Response> putData(
      Map<String, dynamic> data, String apiURL) async {
    var fullUrl = Uri.parse(_baseUrl + apiURL);
    var token = await getToken();
    return await http.put(
      fullUrl,
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<Map<String, dynamic>> updateUserInfo(
      Map<String, dynamic> updatedData) async {
    try {
      final AuthService _authService = AuthService();
      var token = await _authService.getToken();

      // Utiliser http.put pour une mise à jour
      final response = await http.put(
        Uri.parse(
            '${ApiConstants.baseUrl}/user/profile/update'), // Remplacez par le bon endpoint
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(updatedData), // Encoder les données en JSON
      );

      // Vérifier le statut de la réponse
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Vérifier si la réponse contient des données valides
        if (responseData != null && responseData['data'] != null) {
          return responseData['data']; // Retourner les données mises à jour
        } else {
          throw Exception('Réponse invalide de l\'API');
        }
      } else {
        // Gérer les erreurs HTTP
        throw Exception('Échec de la mise à jour : ${response.statusCode}');
      }
    } catch (e) {
      // Gérer les erreurs générales
      throw Exception('Erreur lors de la mise à jour : $e');
    }
  }


// Méthode pour déconnecter l'utilisateur
  Future<void> logout() async {
    
    try {
      final AuthService _authService = AuthService();
    var token = await _authService.getToken();
      if (token == null) {
        throw Exception('Aucun token trouvé');
      }

      // Appeler l'API de déconnexion
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/user/logout'),
       headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      );
      if (response.statusCode == 200) {
        await _authService.clearToken();
        print("success");
      } else {
        print("Echec de deconnection");
        throw Exception('Échec de la déconnexion');
      }
    } catch (e) {
      print("Erreur lors de la déconnexion : $e");
      throw Exception('Erreur lors de la déconnexion : $e');
    }
  }



}
