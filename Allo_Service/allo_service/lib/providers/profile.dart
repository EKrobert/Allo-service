import 'dart:io';

import 'package:allo_service/pages/edit_profile.dart';
import 'package:allo_service/pages/login.dart';
import 'package:allo_service/services/user_connected.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:allo_service/services/auth_service.dart';

class ProfileProvider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileProviderState();
}

class _ProfileProviderState extends State<ProfileProvider> {
  final AuthService _authService = AuthService();
  Map<String, dynamic>? userInfo;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    try {
      // Récupération des informations utilisateur
      var data = await _authService.getUserInfo();
      setState(() {
        userInfo = data;
        isLoading = false;
      });
    } catch (e) {
      print("Erreur lors de la récupération des informations utilisateur : $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCC55FF),
        title: Center(
          child: const Text(
            'Profile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              // Appeler la méthode de déconnexion
              await _authService.logout();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Login()), // Remplacez HomePage par votre page d'accueil
        );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Indicateur de chargement
          : userInfo == null
              ? const Center(
                  child: Text(
                      'Impossible de charger les informations utilisateur.'))
              : Container(
                  color: const Color.fromARGB(255, 197, 225, 239),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListView(
                              children: [
                                Center(
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.indigo,
                                            width: 4.0,
                                          ),
                                        ),
                                        child: const CircleAvatar(
                                          radius: 70,
                                          backgroundImage: AssetImage('assets/images/splashLogo.png'),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Picture',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                                itemProfile(
                                    'Name:',
                                    '${userInfo?['firstname']} ${userInfo?['lastname']}',
                                    Colors.red,
                                    Icons.person),
                                itemProfile('Email:', '${userInfo?['email']}',
                                    Colors.orange, Icons.email),
                                itemProfile('Phone:', '${userInfo?['phone']}',
                                    Colors.blue, Icons.phone),
                                itemProfile(
                                    'Username:',
                                    '${userInfo?['username']}',
                                    Colors.green,
                                    Icons.account_circle),
                                itemProfile('Role:', '${userInfo?['role']}',
                                    Colors.purple, Icons.security),
                                itemProfile(
                                    'Token:',
                                    'token',
                                    Colors.blueAccent,
                                    Icons.lock), // Afficher le token
                                itemProfile('Notification:', '8', Colors.blue,
                                    Icons.business),
                                // itemProfile('Payment', 'Islam', Colors.green,
                                //     Icons.star),
                                const SizedBox(height: 20),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final updatedUserInfo =
                                          await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditProfileScreen(
                                                  userInfo: userInfo!),
                                        ),
                                      );

                                      if (updatedUserInfo != null) {
                                        setState(() {
                                          userInfo = updatedUserInfo;
                                        });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 15),
                                    ),
                                    child: const Text('Edit Profile'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  Widget itemProfile(
      String title, String subtitle, Color iconColor, IconData iconData) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData, color: iconColor),
      ),
    );
  }
}
