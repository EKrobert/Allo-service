import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            margin: EdgeInsets.only(top: 50),
            child: Column(
              children: [
                SizedBox(height: 100),
                Image.asset('assets/images/noConnectionLogo.png'),
                Text(
                  "Oops!",
                  style: TextStyle(
                    fontFamily: 'ComfortaaX',
                    fontSize: 65.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFCC55FF),
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: const Color.fromARGB(255, 186, 186, 186),
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "Something is wrong, check your internet connection and click on Try again.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'ComfortaaX',
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFCC55FF),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                TextButton(
                  onPressed: () {
                    // Add your onPressed code here!
                  },
                  style: TextButton.styleFrom(
                    // Set the button size
                    padding: EdgeInsets.only(
                        left: 23, right: 23, top: 18, bottom: 18),
                    textStyle: TextStyle(
                        fontFamily: 'ComfortaaX',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..color = Colors.white // Set the text color to white
                        ),
                    backgroundColor:
                        Color(0xFFCC55FF), // Set the button color to purple
                    side: BorderSide(
                        color: Color(0xFF6441A5), width: 4), // Border
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Less rounded corners
                    ),
                  ),
                  child: Text('Try Again'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
