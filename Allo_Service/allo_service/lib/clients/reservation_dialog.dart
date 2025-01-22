import 'package:allo_service/services/client/api_reservations.dart';
import 'package:flutter/material.dart';
import 'package:allo_service/models/client_model.dart';

class ReservationDialog extends StatefulWidget {
  final Service service;
  final Prestataire prestataire;

  const ReservationDialog({
    Key? key,
    required this.service,
    required this.prestataire,
  }) : super(key: key);

  @override
  _ReservationDialogState createState() => _ReservationDialogState();
}

class _ReservationDialogState extends State<ReservationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  DateTime? _selectedDate; // Pour stocker la date sélectionnée
  // TimeOfDay? _selectedTime; // Pour stocker l'heure sélectionnée (commenté)

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  // Méthode pour afficher le sélecteur de date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Date initiale
      firstDate: DateTime.now(), // Date minimale
      lastDate: DateTime(2100), // Date maximale
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked; // Mettre à jour la date sélectionnée
      });
    }
  }

  // Méthode pour afficher le sélecteur d'heure (commenté)
  // Future<void> _selectTime(BuildContext context) async {
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(), // Heure initiale
  //   );
  //   if (picked != null && picked != _selectedTime) {
  //     setState(() {
  //       _selectedTime = picked; // Mettre à jour l'heure sélectionnée
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Réserver un service',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Champ de sélection de date
              ListTile(
                title: Text(
                  _selectedDate == null
                      ? 'Choisir une date'
                      : 'Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}', // Afficher la date sélectionnée
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                ),
                leading: Icon(Icons.calendar_today, color: Colors.deepPurple),
                onTap: () => _selectDate(context), // Ouvrir le sélecteur de date
              ),
              SizedBox(height: 16),

              // Champ de sélection d'heure (commenté)
              // ListTile(
              //   title: Text(
              //     _selectedTime == null
              //         ? 'Choisir une heure'
              //         : 'Heure: ${_selectedTime!.format(context)}', // Afficher l'heure sélectionnée
              //     style: TextStyle(
              //       fontSize: 16,
              //       color: Colors.grey[800],
              //     ),
              //   ),
              //   leading: Icon(Icons.access_time, color: Colors.deepPurple),
              //   onTap: () => _selectTime(context), // Ouvrir le sélecteur d'heure
              // ),
              // SizedBox(height: 16),

              // Champ de saisie de l'adresse
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Adresse',
                  prefixIcon: Icon(Icons.location_on, color: Colors.deepPurple),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir une adresse';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actionsPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Fermer le dialogue
          },
          child: Text(
            'Annuler',
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 16,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate() &&
                _selectedDate != null) {
              // Envoyer les données de réservation
              _confirmReservation(context);
            } else if (_selectedDate == null) {
              // Afficher un message si la date n'est pas sélectionnée
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Veuillez choisir une date.'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFCC55FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'Confirmer',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _confirmReservation(BuildContext context) async {
    final date = _selectedDate!.toLocal().toString().split(' ')[0]; // Formater la date
    final address = _addressController.text;

    // Ici, vous pouvez envoyer les données de réservation à votre API
    print('Réservation confirmée :');
    print('Service: ${widget.service.name}');
    print('Prestataire: ${widget.prestataire.id} ${widget.prestataire.lastname}');
    print('Date: $date');
    print('Adresse: $address');

    // Combiner la date pour créer un DateTime complet
    final reservationDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
    );

    try {
      // Appeler l'API pour créer la réservation
      final response = await ApiReservations.createReservation(
        prestataireId: widget.prestataire.id, // ID du prestataire
        serviceId: widget.service.id, // ID du service
        reservationDate: reservationDateTime.toIso8601String(), // Date au format ISO 8601
        adresse: address, // Adresse
      );

      // Fermer le dialogue
      Navigator.of(context).pop();

      // Afficher un message de succès
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Réservation confirmée avec succès !'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Gestion des erreurs
      Navigator.of(context).pop(); // Fermer le dialogue en cas d'erreur

      // Afficher un message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la création de la réservation: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}