class RatingModel {
  final double stars;
  final String? comment;
  final DateTime createdAt;

  RatingModel({
    required this.stars,
    this.comment,
    required this.createdAt,
  });
}
