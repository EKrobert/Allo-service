import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating; // La note (nombre d'étoiles)
  final double starSize; // Taille des étoiles
  final Color starColor; // Couleur des étoiles

  const StarRating({
    required this.rating,
    this.starSize = 24.0,
    this.starColor = Colors.amber,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150, // Limitez la largeur de la Row
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Espacement égal entre les étoiles
        children: List.generate(5, (index) {
          return Icon(
            index < rating ? Icons.star : Icons.star_border,
            size: starSize,
            color: starColor,
          );
        }),
      ),
    );
  }
}