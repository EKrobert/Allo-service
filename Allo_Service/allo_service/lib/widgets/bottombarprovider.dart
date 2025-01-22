import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavBarProvider extends StatefulWidget {
  final int currentPage;
  final Function(int) onPageChanged;

  // Constructeur de BottomNavBar avec les paramètres nécessaires
  const BottomNavBarProvider({required this.currentPage, required this.onPageChanged});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBarProvider> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: widget.currentPage, // Utilisation de 'widget' pour accéder aux paramètres
      items: <Widget>[
        _buildNavItem(Icons.account_circle, 'Profile', 0),
        _buildNavItem(Icons.event, 'Reservation', 1),
        // _buildNavItem(Icons.location_on, 'Location', 2),
        _buildNavItem(Icons.build, 'Services', 2),
        // _buildNavItem(Icons.person, 'Profile', 4),
        _buildNavItem(Icons.settings, 'Settings', 3),
      ],
      color: Color(0xFFCC55FF),
      buttonBackgroundColor: Color(0xFFCC55FF),
      backgroundColor: Colors.white,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 300),
      onTap: (index) {
        print('Page $index sélectionnée');
        widget.onPageChanged(index); // Appel de la fonction de changement de page
      },
      letIndexChange: (index) => true,
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = widget.currentPage == index;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 30,
          color: isSelected ? Colors.white : Colors.white70,
        ),
        if (!isSelected)
          SizedBox(height: 4),
        if (!isSelected)
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
      ],
    );
  }
}
