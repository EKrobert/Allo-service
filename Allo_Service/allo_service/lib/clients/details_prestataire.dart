import 'package:allo_service/clients/reservation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:allo_service/models/client_model.dart';

class PrestataireDetailsPage extends StatelessWidget {
  final Service service;
  final Prestataire prestataire;

  const PrestataireDetailsPage({
    Key? key,
    required this.service,
    required this.prestataire,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Détails du prestataire',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFFCC55FF),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image de profil du prestataire
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(
                    'assets/images/default.jpg'), // Remplacez par l'image du prestataire
              ),
            ),
            SizedBox(height: 20),

            // Informations du service
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Service',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      service.name,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      prestataire.prix != null
                          ? '${prestataire.prix} MAD'
                          : 'Prix non disponible',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      service.description ?? 'Description', // Texte par défaut
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Informations du prestataire
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prestataire',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: 8),
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.deepPurple),
                      title: Text(
                        '${prestataire.firstname} ${prestataire.lastname}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.email, color: Colors.deepPurple),
                      title: Text(
                        prestataire.email,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone, color: Colors.deepPurple),
                      title: Text(
                        prestataire.phone,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Bouton de réservation
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showReservationDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFCC55FF),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Réserver ce service',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReservationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ReservationDialog(
          service: service,
          prestataire: prestataire,
        );
      },
    );
  }
}
