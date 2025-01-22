import 'package:allo_service/clients/reservation.dart';
import 'package:allo_service/clients/startRating.dart';
import 'package:allo_service/models/evaluation_model.dart';
import 'package:allo_service/services/client/api_evaluation.dart';
import 'package:flutter/material.dart';
import 'package:allo_service/services/client/api_reservations.dart';
import 'package:allo_service/clients/evaluations.dart'; // Importez le dialogue d'évaluation

class DetailReservationClient extends StatefulWidget {
  final String reservationId;

  DetailReservationClient({required this.reservationId});

  @override
  _DetailReservationClientScreenState createState() =>
      _DetailReservationClientScreenState();
}

class _DetailReservationClientScreenState
    extends State<DetailReservationClient> {
  Map<String, dynamic>? reservationDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchReservationDetails();
  }

  void _fetchReservationDetails() async {
  try {
    final details =
        await ApiReservations.fetchReservationDetails(widget.reservationId);
    print("Réponse de l'API : $details");
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

void _showEvaluationDialog() async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      return Builder(
        builder: (innerContext) {
          return EvaluationDialog(
            onEvaluate: (int rating, String comment) async {
              try {
                // Vérifier que les données nécessaires sont présentes
                final reservationId = reservationDetails?['reservation']?['id'];
                final prestataireId = reservationDetails?['reservation']?['prestataire']?['id'];

                if (reservationId == null || prestataireId == null) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Données de réservation manquantes ou invalides.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  return false; // Retourner false en cas d'erreur
                }

                // Créer un objet Evaluation
                final evaluation = Evaluation(
                  reservationId: reservationId,
                  prestataireId: prestataireId,
                  rating: rating,
                  comment: comment,
                );

                // Soumettre l'évaluation
                await ApiEvaluation.submitEvaluation(evaluation);

                // Retourner true pour indiquer que l'évaluation a réussi
                return true;
              } catch (e) {
                print('Erreur lors de l\'enregistrement de l\'évaluation : $e');
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erreur lors de l\'enregistrement de l\'évaluation : $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                return false; // Retourner false en cas d'erreur
              }
            },
          );
        },
      );
    },
  );

  // Si l'évaluation a réussi, rafraîchir les détails
  if (result == true && mounted) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Reservation() // Remplacez par votre page de liste des réservations
      ),
    );

    // Afficher un message de succès sur la nouvelle page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Évaluation soumise avec succès!'),
        backgroundColor: Colors.green,
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
        ? Center(child: CircularProgressIndicator())
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
                              'Prix: ${reservationDetails!['prix']} MAD',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Description: ${reservationDetails!['reservation']['service']['description']}',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Section Prestataire
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
                                  'Prestataire',
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
                              '${reservationDetails!['reservation']['prestataire']['user']['firstname']} ${reservationDetails!['reservation']['prestataire']['user']['lastname']}',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.email, color: Colors.grey[700]),
                                SizedBox(width: 10),
                                Text(
                                  '${reservationDetails!['reservation']['prestataire']['user']['email']}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[700]),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.phone, color: Colors.grey[700]),
                                SizedBox(width: 10),
                                Text(
                                  '${reservationDetails!['reservation']['prestataire']['user']['phone']}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[700]),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                    color: Colors.grey[700]),
                                SizedBox(width: 10),
                                Text(
                                  '${reservationDetails!['reservation']['adresse']}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[700]),
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
                                Icon(Icons.calendar_today,
                                    color: Colors.deepPurple),
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: reservationDetails!['reservation']
                                                ['statut'] ==
                                            'validé'
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
                            // Afficher l'évaluation si elle existe, sinon afficher le bouton "Évaluer le service"
                            if (reservationDetails!['reservation']['statut'] ==
                                'validé')
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Center(
                                  child: reservationDetails!['evaluation'] != null
                                      ? Column(
                                          children: [
                                            Text(
                                              'Evaluation :',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
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
                                        )
                                      : ElevatedButton(
                                          onPressed: _showEvaluationDialog,
                                          child: Text(
                                            'Évaluer le service',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.deepPurple,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                          ),
                                        ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
  );
}
}