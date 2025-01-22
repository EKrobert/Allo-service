class Evaluation {
  final int reservationId;
  final int prestataireId;
  final int rating;
  final String comment;

  Evaluation({
    required this.reservationId,
    required this.prestataireId,
    required this.rating,
    required this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      'reservation_id': reservationId,
      'prestataire_id': prestataireId,
      'rating': rating,
      'comment': comment,
    };
  }
}