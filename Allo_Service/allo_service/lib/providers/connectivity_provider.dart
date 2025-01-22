import 'package:flutter/material.dart';
import 'package:allo_service/services/connectivity_service.dart';

class ConnectivityProvider with ChangeNotifier {
  final ConnectivityService connectivityService = ConnectivityService();
  bool _isConnected = true;

  ConnectivityProvider() {
    connectivityService.connectionStatusStream.listen((status) {
      _isConnected = status;
      notifyListeners();
    });
  }

  bool get isConnected => _isConnected;

  void disposeService() {
    connectivityService.dispose();
    super.dispose();
  }
}
