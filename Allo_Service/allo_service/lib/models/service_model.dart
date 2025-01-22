// lib/models/service.dart

class Services {
  final int id;
  final String name;
  final String description;

  Services({
    required this.id,
    required this.name,
    required this.description,
  });

  // Méthode pour créer un objet Service à partir de la réponse JSON
  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
