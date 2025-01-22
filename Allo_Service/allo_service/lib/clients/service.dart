import 'dart:convert';
import 'package:allo_service/clients/details_prestataire.dart';
import 'package:allo_service/models/client_model.dart';
import 'package:allo_service/services/client/api_services_client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  int _selectedCategoryIndex = 0;
  List<String> _categories = ['Tous les services']; // Catégorie par défaut
  List<Service> _services = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchServices();
  }

  Future<void> _fetchServices() async {
    try {
      final apiResponse = await ApiServiceClient.fetchServices();
      print(apiResponse); // Afficher la réponse de l'API pour le débogage

      // Vérifier si le widget est toujours monté avant d'appeler setState
      if (mounted) {
        setState(() {
          _services = (apiResponse.data['prestataire'] as List)
              .map((json) => Service.fromJson(json))
              .toList();

          // Ajouter les noms des services à la liste des catégories
          _categories
              .addAll(_services.map((service) => service.name).toSet().toList());
          _isLoading = false;
        });
      }
    } catch (e) {
      // Vérifier si le widget est toujours monté avant d'appeler setState
      if (mounted) {
        setState(() {
          _errorMessage = 'Erreur de connexion: $e'; // Afficher l'erreur complète
          _isLoading = false;
        });
      }
    }
  }

  // Méthode pour filtrer les services en fonction de la catégorie sélectionnée
  List<Service> _filteredServices() {
    String selectedCategory = _categories[_selectedCategoryIndex];

    if (selectedCategory == 'Tous les services') {
      return _services; // Afficher tous les services
    } else {
      return _services
          .where((service) => service.name == selectedCategory)
          .toList(); // Filtrer par catégorie
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredServices = _filteredServices();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Service',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFCC55FF), Color(0xFFAA44CC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      // Liste des catégories
                      Container(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _categories.length,
                          itemBuilder: (context, index) {
                            final isSelected = index == _selectedCategoryIndex;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategoryIndex = index;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Color(0xFFAA44CC)
                                      : Color(0xFFCC55FF),
                                  borderRadius: BorderRadius.circular(12.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 5,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    _categories[index],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      // Bannière
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/banner.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      // Liste des prestataires filtrés
                      SizedBox(
                        height: 300,
                        child: GridView.builder(
                          padding: const EdgeInsets.all(8.0),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1,
                          ),
                          itemCount: filteredServices.length,
                          itemBuilder: (context, index) {
                            final service = filteredServices[index];
                            final prestataire = service.prestataires.isNotEmpty
                                ? service.prestataires[0]
                                : null;

                            return GestureDetector(
                              onTap: () {
                                if (prestataire != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PrestataireDetailsPage(
                                        service: service,
                                        prestataire: prestataire,
                                      ),
                                    ),
                                  );
                                  print(prestataire.id);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFCC55FF).withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 10,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        service.name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis, // Gestion du débordement
                                        maxLines: 1, // Limite à une seule ligne
                                      ),
                                      if (prestataire != null) ...[
                                        SizedBox(height: 8),
                                        Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Icon(
      Icons.attach_money,
      color: Colors.white,
      size: 16,
    ),
    SizedBox(width: 4),
    Text(
      prestataire.prix != null ? '${prestataire.prix} MAD' : 'Prix non disponible', // Gestion du prix null
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
    ),
  ],
),
 SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.person,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                            SizedBox(width: 4),
                                            Flexible(
                                              child: Text(
                                                '${prestataire.firstname} ${prestataire.lastname}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                                overflow: TextOverflow.ellipsis, // Gestion du débordement
                                                maxLines: 1, // Limite à une seule ligne
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.email,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                            SizedBox(width: 4),
                                            Expanded(
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Text(
                                                  prestataire.email,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                            SizedBox(width: 4),
                                            Flexible(
                                              child: Text(
                                                prestataire.phone,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                                overflow: TextOverflow.ellipsis, // Gestion du débordement
                                                maxLines: 1, // Limite à une seule ligne
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}