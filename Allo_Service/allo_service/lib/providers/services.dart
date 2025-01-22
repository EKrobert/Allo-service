import 'package:allo_service/services/provider/add_service.dart';
import 'package:flutter/material.dart';
import 'package:allo_service/providers/subscribe_page.dart';
import 'package:allo_service/services/provider/api_service.dart';

class ProviderService extends StatefulWidget {
  @override
  _ProviderService createState() => _ProviderService();
}

class _ProviderService extends State<ProviderService> {
  List<Map<String, dynamic>> services = [];
  bool isLoading = true; // Indicateur de chargement

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  // Charger les services depuis l'API
  void _loadServices() async {
    try {
      final response = await ApiService.fetchServices(); // Récupère la réponse brute
      final List<dynamic> fetchedServices = response; // Extrait la liste
      // Vérifier si le widget est toujours monté avant de mettre à jour l'état
      if (mounted) {
        setState(() {
          services = fetchedServices.map((service) {
            return {
              'id': service['id'],
              'name': service['name'], // Nom du service
              'description': service['description'], // Description du service
            };
          }).toList();
          isLoading = false;
        });
      }
    } catch (e) {
      print('Erreur lors de la récupération des services: $e');
      // Vérifier si le widget est toujours monté avant de mettre à jour l'état
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Fonction pour gérer l'abonnement à un service
  void _subscribeToService(int serviceId, String serviceName, String serviceDescription) async {
    final shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubscribeServicePage(
          serviceId: serviceId,
          serviceName: serviceName,
          serviceDescription: serviceDescription,
        ),
      ),
    );

    // Si shouldRefresh est true, rafraîchir la liste des services
    if (shouldRefresh == true) {
      _loadServices();
    }
  }

  // Fonction pour afficher le dialogue d'ajout de service
  void _showAddServiceDialog() {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Ajouter un service'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nom du service',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un nom';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description (optionnelle)',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fermer le dialogue
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    // Ajouter le service via l'API
                    final response = await ApiAddService.createService(
                      _nameController.text,
                      description: _descriptionController.text.isEmpty
                          ? null
                          : _descriptionController.text,
                    );
                    print(_nameController.text);
                    if (response['success'] == true) {
                      // Rafraîchir la liste des services
                      _loadServices();
                      Navigator.pop(context); // Fermer le dialogue
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Service ajouté avec succès !')),
                      );
                    } else {
                      // Afficher un message d'erreur
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Erreur: ${response['message']}')),
                      );
                    }
                  } catch (e) {
                    print('Erreur lors de l\'ajout du service: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erreur: $e')),
                    );
                  }
                }
              },
              child: Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCC55FF),
        title: Text(
          'List of Services',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        // Ajout du bouton "Ajouter" dans l'AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: _showAddServiceDialog, // Afficher le dialogue d'ajout
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(), // Indicateur de chargement
            )
          : services.isEmpty
              ? Center(
                  child: Text(
                    'Aucun service disponible pour le moment',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              : ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final service = services[index];

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        leading: Icon(
                          Icons.design_services,
                          size: 40,
                          color: Color(0xFFCC55FF),
                        ),
                        title: Text(
                          service['name'], // Nom du service
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service['description'] ?? 'Pas de description', // Description du service
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () => _subscribeToService(
                                service['id'],
                                service['name'],
                                service['description'] ?? '',
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFCC55FF),
                              ),
                              child: Text('S\'abonner'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}