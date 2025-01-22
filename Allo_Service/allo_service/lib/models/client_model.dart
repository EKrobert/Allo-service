class ApiResponse {
  final bool success;
  final String message;
  final Map<String, dynamic> data;

  ApiResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'],
    );
  }
}

class Service {
  final int id;
  final String name;
  final String? description;
  final List<Prestataire> prestataires;

  Service({
    required this.id,
    required this.name,
    this.description,
    required this.prestataires,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    var prestatairesFromJson = json['prestataires'] as List;
    List<Prestataire> prestatairesList = prestatairesFromJson
        .map((prestataire) => Prestataire.fromJson(prestataire))
        .toList();

    return Service(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      prestataires: prestatairesList,
    );
  }
}

class Prestataire {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String phone;
  final String username;
 final double? prix; // Prix optionnel

  Prestataire({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.username,
    this.prix, // Ajout du prix
  });

  factory Prestataire.fromJson(Map<String, dynamic> json) {
    return Prestataire(
      id: json['id'],
      firstname: json['user']['firstname'],
      lastname: json['user']['lastname'],
      email: json['user']['email'],
      phone: json['user']['phone'],
      username: json['user']['username'],
      prix: json['pivot'] != null ? json['pivot']['prix'].toDouble() : null,
    );
  }
}