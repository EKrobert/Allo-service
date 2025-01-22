import 'package:allo_service/services/provider/api_service.dart';
import 'package:flutter/material.dart';

class SubscribeServicePage extends StatefulWidget {
  final int serviceId; // ID du service
  final String serviceName;
  final String serviceDescription;

  SubscribeServicePage({
    required this.serviceId,
    required this.serviceName,
    required this.serviceDescription,
  });


  @override
  _SubscribeServicePageState createState() => _SubscribeServicePageState();
}

class _SubscribeServicePageState extends State<SubscribeServicePage> {
  final _formKey = GlobalKey<FormState>(); // Clé pour le formulaire
  final _priceController = TextEditingController(); // Contrôleur pour le champ prix

  @override
  void dispose() {
    _priceController.dispose(); // Nettoyer le contrôleur
    super.dispose();
  }

 void _submitPrice() async {
  if (_formKey.currentState!.validate()) {
    final price = double.tryParse(_priceController.text);
    if (price != null) {
      try {
        await ApiService.subscribeToService(widget.serviceId, price);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Service ajouté avec succès !')),
        );

        // Retourner true pour indiquer que la page précédente doit se rafraîchir
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez entrer un prix valide.')),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('S\'abonner au Service'),
        backgroundColor: Color(0xFFCC55FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Afficher le nom du service
              Text(
                'Service: ${widget.serviceName}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // Afficher la description du service
              Text(
                'Description: ${widget.serviceDescription}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              // Champ de saisie pour le prix
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Prix',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un prix';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Veuillez entrer un nombre valide';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Bouton pour soumettre le prix
              Center(
                child: ElevatedButton(
                  onPressed: _submitPrice,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFCC55FF),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Text(
                    'Soumettre',
                    style: TextStyle(fontSize: 18),
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