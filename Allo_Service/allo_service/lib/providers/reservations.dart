import 'dart:convert';

import 'package:allo_service/providers/reservation_details.dart';
import 'package:allo_service/services/provider/reservations.dart';
import 'package:flutter/material.dart';

class ReservationProvider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReservationProvider();
}

class _ReservationProvider extends State<ReservationProvider> {
  List<Map<String, dynamic>> reservations = [];
  bool isLoading = true; // Indicateur de chargement
  @override
  void initState() {
    super.initState();
    _loadReservations();
  }

  // Charger les réservations depuis l'API
  void _loadReservations() async {
    try {
      final response =
          await Api.fetchReservations(); // Récupère la réponse brute
      final Map<String, dynamic> jsonResponse =
          response; // Assure que c'est un Map
      final List<dynamic> fetchedReservations =
          jsonResponse['data']; // Extrait la liste
// Vérifier si le widget est toujours monté avant de mettre à jour l'état
      if (mounted) {
        setState(() {
          setState(() {
            reservations = fetchedReservations.map((reservation) {
              final client = reservation['client']['user'];
              final service = reservation['service'];
              final reservationId = reservation['id'];

              return {
                'id': reservationId,
                'service': service['name'], // Nom du service
                'client':
                    '${client['firstname']} ${client['lastname']}', // Nom complet du client
                'date': reservation['reservation_date'], // Date de réservation
                'status': reservation['statut'], // Statut brut
              };
            }).toList();
          });
          isLoading = false;
        });
      }
    } catch (e) {
      print('Erreur lors de la récupération des réservations: $e');
      // Vérifier si le widget est toujours monté avant de mettre à jour l'état
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFCC55FF),
          title: Text(
            'List of Reservations',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(), // Indicateur de chargement
              )
            : reservations.isEmpty
                ? Center(
                    child: Text(
                      'Aucune réservation pour le moment',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView.builder(
                    itemCount: reservations.length,
                    itemBuilder: (context, index) {
                      final reservation = reservations[index];
                      final statusColor = reservation['status'] == 'validé'
                          ? Colors.green
                          : Colors.orange;

                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/login.png'),
                            radius: 30,
                          ),
                          title: Text(
                            reservation['service'], // Nom du service
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Client: ${reservation['client']}'), // Nom complet du client
                              Text('Date: ${reservation['date']}'), // Date
                              Row(
                                children: [
                                  Text(
                                    'Status: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: statusColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      reservation['status'], // Statut
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () async {
                            // Naviguer vers l'écran de détails avec les données de la réservation
                            final shouldReload = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailReservationProvider(
                                  reservationId: reservation['id'].toString(),
                                  // print(reservationId ) ;
                                ),
                              ),
                            );
                            // Si shouldReload est true, recharger les réservations
                            if (shouldReload == true) {
                              _loadReservations();
                            }
                          },
                        ),
                      );
                    },
                  )
                  );
  }
}
