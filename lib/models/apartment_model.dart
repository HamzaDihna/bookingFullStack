class ApartmentModel {
  final String id;
  final String title;
  final String location;
  final double price;
  final double rating; // average rating
  final String image;
  final int rooms;
  final bool hasWifi;
  final String description;

  bool isFavorite;

  ApartmentModel({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.rating,
    required this.image,
    required this.rooms,
    required this.hasWifi,
    required this.description,
    this.isFavorite = false,
  });

factory ApartmentModel.fromJson(Map<String, dynamic> json) {
    return ApartmentModel(
      id: json['id'].toString(), // تحويل لـ String دائماً للأمان
      title: json['title'] ?? '',
      location: json['location'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
      image: json['profile_image'] ?? '', // تأكد من اسم الحقل من الباك
      rooms: json['rooms'] ?? 0,
      hasWifi: json['has_wifi'] == 1 || json['has_wifi'] == true, // Laravel يرجع boolean كـ 0 أو 1 غالباً
      description: json['description'] ?? '',
      isFavorite: json['is_favorite'] ?? false,
    );
  }}