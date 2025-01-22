import 'package:flutter/material.dart';

class LandscapeErrorPage extends StatelessWidget {
  const LandscapeErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        color: Color(0xFFCC55FF),
        child: Padding(
          padding: EdgeInsets.only(top: 70),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/rotatePhone.png',
                  width: 200,
                  height: 200,
                ),
              ),
              Center(
                child: Text(
                  'Please rotate your device to portrait mode.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: "ComfortaaX",
                    decoration: TextDecoration.none,
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
