import 'package:allo_service/pages/login.dart';
import 'package:allo_service/services/auth_service.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  final AuthService _authService = AuthService();
  Map<String, dynamic>? userInfo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCC55FF),
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Bouton "Update Password"
            _buildSettingsButton(
              icon: Icons.lock,
              text: 'Update Password',
              onPressed: () {
                // Ajoutez ici la logique pour mettre à jour le mot de passe
                print('Update Password clicked');
              },
            ),
            const SizedBox(height: 16), // Espacement entre les boutons

            // Bouton "Delete Account"
            _buildSettingsButton(
              icon: Icons.delete,
              text: 'Delete Account',
              onPressed: () {
                _confirmAction(
                  context,
                  title: 'Delete Account',
                  message: 'Are you sure you want to delete your account? This action cannot be undone.',
                  onConfirm: () {
                    // Ajoutez ici la logique pour supprimer le compte
                    print('Account deleted');
                  },
                );
              },
              isDestructive: true, // Style différent pour un bouton destructif
            ),
            const SizedBox(height: 16), // Espacement entre les boutons

            // Bouton "Logout"
            _buildSettingsButton(
              icon: Icons.logout,
              text: 'Logout',
              onPressed: () {
                _confirmAction(
                  context,
                  title: 'Logout',
                  message: 'Are you sure you want to logout?',
                  onConfirm: () async {
              // Appeler la méthode de déconnexion
              await _authService.logout();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Login()), // Remplacez HomePage par votre page d'accueil
        );
            },
                );
              },
              isDestructive: true, // Style différent pour un bouton destructif
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour construire un bouton de paramètres
  Widget _buildSettingsButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
    bool isDestructive = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        backgroundColor: isDestructive ? Colors.red : const Color(0xFFCC55FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white), // Icône
          const SizedBox(width: 16), // Espacement entre l'icône et le texte
          Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour afficher une boîte de dialogue de confirmation
  void _confirmAction(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Fermer la boîte de dialogue
              onConfirm(); // Exécuter l'action de confirmation
            },
            child: Text(
              'Confirm',
              style: TextStyle(
                color: Colors.red, // Texte en rouge pour les actions destructives
              ),
            ),
          ),
        ],
      ),
    );
  }
}