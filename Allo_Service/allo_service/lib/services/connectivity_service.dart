import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionStatusController =
      StreamController<bool>.broadcast();

  ConnectivityService() {
    // Listen to connectivity changes
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      for (var result in results) {
        _checkConnection(result);
      }
    });
  }

  Stream<bool> get connectionStatusStream => _connectionStatusController.stream;

  void _checkConnection(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      _connectionStatusController.add(false); // No connection
    } else {
      _connectionStatusController.add(true); // Connection available
    }
  }

  void dispose() {
    _connectionStatusController.close();
  }
}
