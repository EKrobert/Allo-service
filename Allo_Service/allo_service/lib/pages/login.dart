import 'dart:convert';

import 'package:allo_service/models/user_model.dart';
import 'package:allo_service/pages/main_page.dart';
import 'package:allo_service/pages/register.dart';
import 'package:allo_service/services/api_register.dart';
import 'package:allo_service/services/auth_service.dart';
import 'package:allo_service/services/user_connected.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _obscurePassword = true; // État pour masquer/démasquer le mot de passe

  void login() async {
    try {
      final response = await ApiService.login({
        'email': emailController.text,
        'password': passwordController.text,
      });

      if (response['success'] == true) {
        // Affichage du message de succès
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Connexion réussie: ${response['message']}")),
        );
        var userData = response['data']['user'];
        var token = response['data']['token'];

        await _authService.saveUserInfo(userData);
        await _authService.saveToken(token);

        // Redirection vers la page d'accueil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomePage()), // Remplacez HomePage par votre page d'accueil
        );
      } else {
        // Affichage du message d'erreur
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur: ${response['message']}")),
        );
      }
    } on Exception catch (e) {
      // Gestion des exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Une erreur s'est produite: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCC55FF),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 190,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 6, 100, 207),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(50),
                  ),
                ),
              ),
              Container(
                height: 175,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(50),
                  ),
                ),
                child: Image.asset(
                  "assets/images/login.png",
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Image.asset(
            "assets/images/loginlg.png",
            height: 80,
            width: 80,
          ),
          SizedBox(height: 8),
          Text(
            "Order what you need now!",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          // Titre Login
          Text(
            "Login",
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          // Champ Email
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: // Champ Email
                _buildFieldWithTitle(
              title: "Email",
              icon: Icons.email,
              controller: emailController,
            ),
          ),
          SizedBox(height: 16),
          // Champ password
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _buildFieldWithTitle(
              title: "Password",
              icon: Icons.lock,
              controller: passwordController,
              obscureText: _obscurePassword, // Utiliser l'état pour masquer/démasquer
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword; // Inverser l'état
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 16),
          // Texte pour l'inscription
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don’t have an account? ",
                  style: TextStyle(color: Colors.white),
                ),
                GestureDetector(
                  onTap: () {
                    // Naviguer vers la page d'accueil
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  child: Text(
                    "Register here",
                    style: TextStyle(
                      color: Colors.yellow, // Changer la couleur ici
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Bouton de connexion
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity, // Le bouton occupe toute la largeur
              child: ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Couleur de fond du bouton
                  foregroundColor: Colors.blue, // Couleur du texte
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 15), // Ajuste la hauteur
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  // Fonction pour créer un champ de texte avec un titre
  Widget _buildFieldWithTitle({
    required String title,
    required IconData icon,
    required TextEditingController controller,
    bool obscureText = false,
    Widget? suffixIcon, // Ajouter un suffixe (icône d'œil)
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white, // Le texte est en blanc
            fontSize: 18, // Taille du texte
            fontWeight: FontWeight.bold, // Gras pour le texte
          ),
        ),
        SizedBox(height: 8), // Espace entre le texte et le champ de texte
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(
            color: Colors.white, // Texte à l'intérieur du champ en blanc
          ),
          decoration: InputDecoration(
            hintText: "Your $title", // Placeholder dynamique
            hintStyle: TextStyle(
              color: Colors.white54, // Couleur du placeholder en blanc clair
            ),
            prefixIcon: Icon(
              icon, // Icône dynamique
              color: Colors.white, // Icône en blanc
            ),
            suffixIcon: suffixIcon, // Ajouter l'icône d'œil ici
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), // Bordure arrondie
              borderSide: BorderSide(color: Colors.white), // Bordure blanche
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  15), // Bordure arrondie quand le champ est focalisé
              borderSide: BorderSide(color: Colors.white), // Bordure blanche
            ),
          ),
        ),
      ],
    );
  }
}