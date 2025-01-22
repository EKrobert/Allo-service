import 'package:allo_service/clients/account.dart';
import 'package:allo_service/clients/location.dart';
import 'package:allo_service/clients/reservation.dart';
import 'package:allo_service/clients/service.dart';
import 'package:allo_service/clients/setting_client.dart';
import 'package:allo_service/models/user_model.dart';
import 'package:allo_service/pages/landscape_error_page.dart';
import 'package:allo_service/pages/login.dart';
import 'package:allo_service/pages/no_internet_page.dart';
import 'package:allo_service/pages/register.dart';
import 'package:allo_service/providers/connectivity_provider.dart';
import 'package:allo_service/providers/myservices.dart';
import 'package:allo_service/providers/profile.dart';
import 'package:allo_service/providers/reservations.dart';
import 'package:allo_service/providers/services.dart';
import 'package:allo_service/services/auth_service.dart';
import 'package:allo_service/services/user_connected.dart';
import 'package:allo_service/widgets/bottom.dart';
import 'package:allo_service/widgets/bottombarprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OrientationMonitor(),
    );
  }
}

class OrientationMonitor extends StatelessWidget {
  const OrientationMonitor({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        // Check the orientation
        if (orientation == Orientation.landscape) {
          return const LandscapeErrorPage(); // Show a specific page for landscape
        } else {
          return Login(); // Default portrait page
        }
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<HomePage> {
  int _currentPage = 0;

  final AuthService _authService = AuthService();
  Map<String, dynamic>? userInfo;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    try {
      // Récupération des informations utilisateur
      var data = await _authService.getUserInfo();
      setState(() {
        userInfo = data;
        isLoading = false;
      });
    } catch (e) {
      print("Erreur lors de la récupération des informations utilisateur : $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // Fonction pour obtenir les pages dynamiquement
  List<Widget> _getPages(String? role) {
    if (userInfo?['role'] == "client") {
      return [
        ProfileClient(),
        Reservation(),
        // Center(child: Text('Location page')),
        ServicePage(),
        SettingsPage()
      ];
    } else {
      return [
        ProfileProvider(),
        ReservationProvider(),
        ProviderService(),
        SubscribedServicesPage()
      ];
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    
    // Détection du rôle et génération des pages
    final pages = _getPages(userInfo?['role']);

    return Scaffold(
      body: pages[_currentPage],
      bottomNavigationBar: userInfo != null && userInfo?['role'] == "client"
          ? BottomNavBar(
              currentPage: _currentPage,
              onPageChanged: _onPageChanged,
            )
          : BottomNavBarProvider(
              currentPage: _currentPage,
              onPageChanged: _onPageChanged,
            ),
    );
  }
}
