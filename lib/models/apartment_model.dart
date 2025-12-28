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
    id: json['id'].toString(),
    title: json['title'] ?? '',
    // دمج المحافظة والمدينة ليعطيك الـ location
    location: "${json['governorate']} - ${json['city']}", 
    price: double.tryParse(json['price_per_night'].toString()) ?? 0.0,
    rating: double.tryParse(json['average_rating'].toString()) ?? 0.0,
    image: json['main_image'] ?? 'assets/images/Group.png', // تأكد من اسم الحقل من الباك
    rooms: json['bedrooms'] ?? 0, // عدلناه ليتطابق مع Migration
    hasWifi: json['has_wifi'] == 1 || json['has_wifi'] == true,
    description: json['description'] ?? '',
    isFavorite: json['is_favorite'] ?? false,
  );
}}