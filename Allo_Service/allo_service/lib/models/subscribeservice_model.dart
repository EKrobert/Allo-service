class SubscribedService {
  final int id;
  final String name;
  final String? description; // La description peut être null
  final double price;

  SubscribedService({
    required this.id,
    required this.name,
    this.description, // Marqué comme nullable
    required this.price,
  });

  factory SubscribedService.fromJson(Map<String, dynamic> json) {
    return SubscribedService(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '', // Fournir une valeur par défaut si null
      price: (json['pivot']['prix'] as num).toDouble(),
    );
  }
}
