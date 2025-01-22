import 'package:allo_service/services/provider/starRating.dart';
import 'package:flutter/material.dart';
import 'package:allo_service/services/provider/reservations.dart';

class DetailReservationProvider extends StatefulWidget {
  final String reservationId; // ID de la réservation

  DetailReservationProvider({required this.reservationId});

  @override
  _DetailReservationScreenState createState() =>
      _DetailReservationScreenState();
}

class _DetailReservationScreenState extends State<DetailReservationProvider> {
  Map<String, dynamic>? reservationDetails; // Détails de la réservation
  bool isLoading = true; // Indicateur de chargement
  bool isReservationValidated = false; // Indicateur de validation

  @override
  void initState() {
    super.initState();
    _fetchReservationDetails(); // Charger les détails de la réservation
  }

  void _fetchReservationDetails() async {
    try {
      final details = await Api.fetchReservationDetails(widget.reservationId);
      print("Réponse de l'API : $details"); // Log pour vérifier la réponse
      if (mounted) {
        setState(() {
          reservationDetails = details;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Erreur lors de la récupération des détails: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Méthode pour valider la réservation
  void _validateReservation() async {
    try {
      // Appeler l'API pour valider la réservation
      await Api.validateReservation(widget.reservationId);
      setState(() {
        isReservationValidated = true; // Mettre à jour l'état de validation
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Réservation validée avec succès !'),
          backgroundColor: Colors.green,
        ),
      );
      // Recharger les détails de la réservation pour mettre à jour le statut
      _fetchReservationDetails();
      // Retourner un résultat à la page précédente
      Navigator.pop(context, true);
    } catch (e) {
      print('Erreur lors de la validation de la réservation: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Échec de la validation de la réservation.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Color(0xFFCC55FF),
      title: Text(
        'Détails de la réservation',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
    ),
    body: isLoading
        ? Center(child: CircularProgressIndicator()) // Indicateur de chargement
        : reservationDetails == null
            ? Center(
                child: Text(
                  'Aucun détail trouvé pour cette réservation.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Service
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.work, color: Colors.deepPurple),
                                SizedBox(width: 10),
                                Text(
                                  'Service',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${reservationDetails!['reservation']['service']['name']}',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Description: ${reservationDetails!['reservation']['service']['description']}',
                              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Section Client
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.person, color: Colors.deepPurple),
                                SizedBox(width: 10),
                                Text(
                                  'Client',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${reservationDetails!['reservation']['client']['user']['firstname']} ${reservationDetails!['reservation']['client']['user']['lastname']}',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.email, color: Colors.grey[700]),
                                SizedBox(width: 10),
                                Text(
                                  '${reservationDetails!['reservation']['client']['user']['email']}',
                                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.phone, color: Colors.grey[700]),
                                SizedBox(width: 10),
                                Text(
                                  '${reservationDetails!['reservation']['client']['user']['phone']}',
                                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.location_on, color: Colors.grey[700]),
                                SizedBox(width: 10),
                                Text(
                                  '${reservationDetails!['reservation']['adresse']}',
                                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Section Date et Statut
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.calendar_today, color: Colors.deepPurple),
                                SizedBox(width: 10),
                                Text(
                                  'Date et Statut',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Date: ${reservationDetails!['reservation']['reservation_date']}',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Statut: ',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: reservationDetails!['reservation']['statut'] == 'validé'
                                        ? Colors.green
                                        : Colors.orange,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    '${reservationDetails!['reservation']['statut']}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Section Évaluation
                    if (reservationDetails!['evaluation'] != null)
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber),
                                  SizedBox(width: 10),
                                  Text(
                                    'Évaluation',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              // Afficher la note avec des étoiles
                              StarRating(
                                rating: reservationDetails!['evaluation']['rating'],
                                starSize: 28.0,
                                starColor: Colors.amber,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Commentaire : ${reservationDetails!['evaluation']['comment']}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Bouton de validation
                    if (reservationDetails!['reservation']['statut'] != 'validé')
                      Center(
                        child: ElevatedButton(
                          onPressed: _validateReservation,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Valider la Réservation',
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
}
