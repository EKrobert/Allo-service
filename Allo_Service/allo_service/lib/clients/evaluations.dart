import 'package:flutter/material.dart';

class EvaluationDialog extends StatefulWidget {
  final Function(int rating, String comment) onEvaluate;

  EvaluationDialog({required this.onEvaluate});

  @override
  _EvaluationDialogState createState() => _EvaluationDialogState();
}

class _EvaluationDialogState extends State<EvaluationDialog> {
  int rating = 0; // Variable pour stocker la note sélectionnée
  String comment = ''; // Variable pour stocker le commentaire

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Évaluer le service'),
      content: Container(
        width: 300, // Largeur fixe pour éviter les débordements
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Notez le service (1 à 5 étoiles)'),
              SizedBox(height: 10),
              // Afficher les étoiles
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        rating = index + 1;
                      });
                    },
                  );
                }),
              ),
              SizedBox(height: 10),
              Text(
                'Note sélectionnée : $rating/5',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              // Champ de commentaire
              TextField(
                decoration: InputDecoration(
                  labelText: 'Commentaire (optionnel)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  comment = value;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Annuler'),
        ),
        TextButton(
          onPressed: () {
            widget.onEvaluate(rating, comment);
            Navigator.of(context).pop();
          },
          child: Text('Soumettre'),
        ),
      ],
    );
  }
}