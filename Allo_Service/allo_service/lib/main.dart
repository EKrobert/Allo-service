import 'package:allo_service/pages/main_page.dart'; // Add this import
import 'package:allo_service/providers/connectivity_provider.dart';
import 'package:allo_service/services/user_connected.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
        ChangeNotifierProvider(create: (_) => UserCredential()), 
      ],
      child: MainApp(),
    ),
  );
}
