import 'package:flutter/material.dart';
import 'package:allo_service/services/auth_service.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> userInfo;

  const EditProfileScreen({Key? key, required this.userInfo}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstnameController;
  late TextEditingController _lastnameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _firstnameController = TextEditingController(text: widget.userInfo['firstname']);
    _lastnameController = TextEditingController(text: widget.userInfo['lastname']);
    _emailController = TextEditingController(text: widget.userInfo['email']);
    _phoneController = TextEditingController(text: widget.userInfo['phone']);
    _usernameController = TextEditingController(text: widget.userInfo['username']);
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      final updatedData = {
        'firstname': _firstnameController.text,
        'lastname': _lastnameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'username': _usernameController.text,
      };

      try {
        final AuthService _authService = AuthService();
        final updatedUserInfo = await _authService.updateUserInfo(updatedData);
        await _authService.saveUserInfo(updatedUserInfo['user']);
        Navigator.pop(context, updatedUserInfo['user']);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profil mis à jour avec succès !")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la mise à jour : $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFCC55FF),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 253, 253, 253)),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _updateProfile,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Champ Prénom
              TextFormField(
                controller: _firstnameController,
                decoration: InputDecoration(
                  labelText: 'Prénom',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0), // Bordure arrondie
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre prénom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Champ Nom
              TextFormField(
                controller: _lastnameController,
                decoration: InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0), // Bordure arrondie
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Champ Email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0), // Bordure arrondie
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Champ Téléphone
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Téléphone',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0), // Bordure arrondie
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre téléphone';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Champ Nom d'utilisateur
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Nom d\'utilisateur',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0), // Bordure arrondie
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom d\'utilisateur';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Bouton de mise à jour
              Center(
                child: ElevatedButton(
                  onPressed: _updateProfile,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32), // Ajustez la taille du bouton
                    minimumSize: Size(double.infinity, 50), // Largeur maximale et hauteur de 50
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Bordure arrondie
                    ),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(fontSize: 18), // Taille du texte augmentée
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}