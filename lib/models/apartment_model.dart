class ApartmentModel {
   String id;
   String title;
   String location;
   double price;
   double rating; // average rating
   String image;
   int rooms;
   bool hasWifi;
   String description;

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
  String imageUrl = 'assets/images/Group.png';

  if (json['main_image'] != null && json['main_image'].toString().isNotEmpty) {
    imageUrl = json['main_image'];
  } else if (json['images'] != null && json['images'] is List && json['images'].isNotEmpty) {
    final firstImage = json['images'][0];
    if (firstImage['image_path'] != null) {
      imageUrl = firstImage['image_path'].startsWith('http')
          ? firstImage['image_path']
          : 'https://nonevil-emmalynn-inoperative.ngrok-free.dev/storage/${firstImage['image_path']}';
    }
  }

  return ApartmentModel(
    id: json['id'].toString(),
    title: json['title'] ?? '',
    location: "${json['governorate']} - ${json['city']}",
    price: double.tryParse(json['price_per_night'].toString()) ?? 0.0,
    rating: double.tryParse(json['average_rating']?.toString() ?? '') ?? 0.0,
    image: imageUrl,
    rooms: int.tryParse(json['bedrooms'].toString()) ?? 0,
    hasWifi: json['has_wifi'] == 1 || json['has_wifi'] == true,
    description: json['description'] ?? '',
    isFavorite: json['is_favorite'] ?? false,
  );
}}