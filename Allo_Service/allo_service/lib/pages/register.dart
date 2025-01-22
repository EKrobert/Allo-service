import 'package:allo_service/pages/login.dart';
import 'package:allo_service/services/api_register.dart';
import 'package:flutter/material.dart';
import 'package:allo_service/models/user_model.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<StatefulWidget> createState() => _Register();
}

class _Register extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String selectedRole = "client";
  bool isAccepted = false;
  bool _isLoading = false;
  int _currentStep = 0; // Pour gérer les étapes du formulaire

 Future<void> registerUser() async {
  if (_formKey.currentState!.validate() && isAccepted) {
    setState(() {
      _isLoading = true;
    });

    final user = User(
      firstname: firstNameController.text,
      lastname: lastNameController.text,
      email: emailController.text,
      phone: phoneController.text,
      username: usernameController.text,
      password: passwordController.text,
      role: selectedRole,
    );

    try {
      final response = await ApiService.registerUser(user.toJson());

      // Vérifier si le widget est toujours monté avant de continuer
      if (!mounted) return;

      // Si l'inscription réussit
      if (response['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Inscription réussie: ${response['message']}")),
        );

        // Vider les champs et rediriger vers la page de connexion
        firstNameController.clear();
        lastNameController.clear();
        emailController.clear();
        phoneController.clear();
        usernameController.clear();
        passwordController.clear();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else if (response['success'] == false) {
        // Si l'API renvoie une erreur
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Échec: ${response['errors']}")),
        );
      }
    } catch (error) {
      // Vérifier si le widget est toujours monté avant de continuer
      if (!mounted) return;

      // En cas d'erreur réseau ou autre
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur: ${error.toString()}")),
      );
    } finally {
      // Vérifier si le widget est toujours monté avant de continuer
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  } else {
    // Si les conditions ne sont pas acceptées ou si la validation échoue
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Veuillez accepter les conditions et vérifier les champs."),
      ),
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
            // Image en haut
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 190,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(50),
                    ),
                  ),
                ),
                Container(
                  height: 185,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 6, 100, 207),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(50),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[200],
                  child: Icon(
                    Icons.account_circle,
                    size: 80,
                    color: const Color.fromARGB(255, 6, 100, 207),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Texte principal
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Join more than 10k+ Professionals and 80k+ clients Today!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            // Formulaire en deux étapes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Étape 1 : Informations de base
                    if (_currentStep == 0) ...[
                      _buildFieldWithTitle("First Name", Icons.person,
                          controller: firstNameController),
                      SizedBox(height: 10),
                      _buildFieldWithTitle("Last Name", Icons.person_outline,
                          controller: lastNameController),
                      SizedBox(height: 10),
                      _buildFieldWithTitle("Email", Icons.email,
                          controller: emailController),
                      SizedBox(height: 10),
                      _buildFieldWithTitle("Phone", Icons.phone,
                          controller: phoneController),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _currentStep = 1; // Passer à l'étape suivante
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: Color(0xFFCC55FF),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],

                    // Étape 2 : Informations supplémentaires
                    if (_currentStep == 1) ...[
                      _buildFieldWithTitle("Username", Icons.account_box,
                          controller: usernameController),
                      SizedBox(height: 10),
                     _buildFieldWithTitle("Password", Icons.lock, obscureText: true, controller: passwordController),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedRole = "client";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selectedRole == "client"
                                  ? Colors.blue
                                  : Colors.white,
                              foregroundColor: selectedRole == "client"
                                  ? Colors.white
                                  : Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (selectedRole == "client")
                                  Container(
                                    margin: EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.all(5),
                                    child: Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Colors.blue,
                                    ),
                                  ),
                                Text(
                                  "Client",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedRole = "provider";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selectedRole == "provider"
                                  ? Colors.blue
                                  : Colors.white,
                              foregroundColor: selectedRole == "provider"
                                  ? Colors.white
                                  : Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (selectedRole == "provider")
                                  Container(
                                    margin: EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.all(5),
                                    child: Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Colors.blue,
                                    ),
                                  ),
                                Text(
                                  "Provider",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Checkbox(
                            value: isAccepted,
                            onChanged: (bool? value) {
                              setState(() {
                                isAccepted = value ?? false;
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                              "I agree to the privacy policy and terms and conditions",
                              style: TextStyle(
                                fontSize: 14,
                                color: const Color.fromARGB(255, 212, 11, 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Aligner les boutons
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _currentStep =
                                    0; // Revenir à l'étape précédente
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.white, // Même couleur que "Next"
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              "Back",
                              style: TextStyle(
                                color: Color(
                                    0xFFCC55FF), // Même couleur que "Next"
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 10), // Espace entre les boutons
                          ElevatedButton(
                            onPressed: registerUser,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .white, // Couleur blanche pour "Register"
                              padding: EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 50), // Taille augmentée
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              "Register",
                              style: TextStyle(
                                color: Color(0xFFCC55FF), // Couleur du texte
                                fontSize: 18, // Taille du texte augmentée
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Lien vers la page de connexion
            Center(
              // Centrer le texte "Register"
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Text(
                  "Already have an account? Login here",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

 Widget _buildFieldWithTitle(String title, IconData icon,
    {bool obscureText = false, required TextEditingController controller}) {
  // Ajoutez une variable pour gérer l'état de visibilité du mot de passe
  bool isPasswordVisible = false;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 5),
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return TextField(
            controller: controller,
            obscureText: obscureText && !isPasswordVisible, // Masquer le mot de passe si nécessaire
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.white),
              suffixIcon: obscureText
                  ? IconButton(
                      icon: Icon(
                        isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible; // Basculer l'état de visibilité
                        });
                      },
                    )
                  : null,
              filled: true,
              fillColor: Colors.white.withOpacity(0.2),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white, width: 2),
              ),
              hintText: title,
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
            style: TextStyle(color: Colors.white),
          );
        },
      ),
    ],
  );
}
}
