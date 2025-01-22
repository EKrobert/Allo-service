import 'package:flutter/material.dart';
class UserCredential extends ChangeNotifier {
  Map<String, dynamic> _user = {};
  String _token = '';

  Map<String, dynamic> get user => _user;
  String get token => _token;

  void setUser(Map<String, dynamic> userData) {
    _user = userData;  // Assurez-vous que _user contient bien les données de l'utilisateur
    _token = userData['token'];  // Stocker le token
    notifyListeners();  // Notifie les widgets qui écoutent ce modèle
  }



}
