import 'package:allo_service/models/subscribeservice_model.dart';
import 'package:allo_service/services/provider/api_service.dart';
import 'package:flutter/material.dart';

class SubscribedServicesPage extends StatefulWidget {
  @override
  _SubscribedServicesPageState createState() => _SubscribedServicesPageState();
}

class _SubscribedServicesPageState extends State<SubscribedServicesPage> {
  List<SubscribedService> services = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSubscribedServices();
  }

  void _loadSubscribedServices() async {
    try {
      final fetchedServices = await ApiService.getSubscribedServices();
      setState(() {
        services = fetchedServices;
        isLoading = false;
      });
    } catch (e) {
      print('Erreur lors du chargement des services: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCC55FF),
        title: Text(
          'My Services',
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
          : services.isEmpty
              ? Center(child: Text('Aucun service abonné pour le moment'))
              : ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final service = services[index];

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: ListTile(
                        title: Text(
                          service.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service.description ?? 'Aucune description disponible',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Prix: ${service.price.toString()} MAD', // Afficher le prix en lecture seule
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
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