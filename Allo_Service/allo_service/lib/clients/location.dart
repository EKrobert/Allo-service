import 'package:flutter/material.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<StatefulWidget> createState() => _Location();
  
}

class _Location extends State <LocationPage>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
        backgroundColor: Color(0xFFCC55FF),
        title: Text(
          'Service',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),

   );
  }
  
}