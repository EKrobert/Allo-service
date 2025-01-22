class Reservation {
  final int id;
  final String service;
  final String client;
  final String prestataire;
  final String statut;
  final String reservationDate;

  Reservation({
    required this.id,
    required this.service,
    required this.client,
    required this.prestataire,
    required this.statut,
    required this.reservationDate,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      service: json['service']['name'],
      client: json['client']['name'],
      prestataire: json['prestataire']['name'],
      statut: json['statut'],
      reservationDate: json['reservation_date'],
    );
  }
}
