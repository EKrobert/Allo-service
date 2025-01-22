import 'package:allo_service/clients/reservation_details.dart';
import 'package:allo_service/services/client/api_reservations.dart';
import 'package:flutter/material.dart';

class Reservation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Reservation();

}

class _Reservation extends State<Reservation> {
  List<Map<String, dynamic>> reservations = []; // Liste des réservations
  bool isLoading = true; // Indicateur de chargement

  @override
  void initState() {
    super.initState();
    _loadReservations(); // Charger les réservations au démarrage
  }

void _loadReservations() async {
  try {
    final response = await ApiReservations.fetchReservations(); // Appeler l'API
    print(response);
    final Map<String, dynamic> jsonResponse = response; // Convertir la réponse en Map
    final List<dynamic> fetchedReservations = jsonResponse['data']; // Extraire la liste des réservations

    // Vérifier si le widget est toujours monté avant d'appeler setState
    if (mounted) {
      setState(() {
        reservations = fetchedReservations.map((reservation) {
          return {
            'id': reservation['id'],
            'service': reservation['service']['name'], // Nom du service
            'prestataire': '${reservation['prestataire']['user']['firstname']} ${reservation['prestataire']['user']['lastname']}', // Nom complet du prestataire
            'date': reservation['reservation_date'], // Date de réservation
            'status': reservation['statut'], // Statut de la réservation
          };
        }).toList();
        isLoading = false; // Fin du chargement
      });
    }
  } catch (e) {
    print('Erreur lors de la récupération des réservations: $e');
    // Vérifier si le widget est toujours monté avant d'appeler setState
    if (mounted) {
      setState(() {
        isLoading = false; // Fin du chargement même en cas d'erreur
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
          'My Reservations',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFCC55FF), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: isLoading
            ? Center(child: CircularProgressIndicator()) // Indicateur de chargement
            : reservations.isEmpty
                ? Center(child: Text('Aucune réservation pour le moment')) // Aucune donnée
                : ListView.builder(
                    itemCount: reservations.length,
                    itemBuilder: (context, index) {
                      final reservation = reservations[index];
                      final statusColor = reservation['status'] == 'validé'
                          ? Colors.green
                          : Colors.orange;

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/images/login.png'), // Image par défaut
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
                              Text('Prestataire: ${reservation['prestataire']}'), // Nom du prestataire
                              Text('Date: ${reservation['date']}'), // Date de réservation
                              Row(
                                children: [
                                  Text(
                                    'Status: ',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: statusColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      reservation['status'], // Statut de la réservation
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
                                builder: (context) => DetailReservationClient(
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
                  ),
      ),
    );
  }
}