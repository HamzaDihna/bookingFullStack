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
  return ApartmentModel(
     id: json['id'].toString(),
    title: json['title'] ?? '',
    location: "${json['governorate']} - ${json['city']}",
    price: double.tryParse(json['price_per_night'].toString()) ?? 0.0,
    rating: double.tryParse(json['average_rating']?.toString() ?? '') ?? 0.0,
    image: (json['images'] != null && json['images'].isNotEmpty)
        ? json['images'][0]['path']
        : 'assets/images/Group.png',
    rooms: int.tryParse(json['bedrooms'].toString()) ?? 0,
    hasWifi: json['has_wifi'] == 1 || json['has_wifi'] == true,
    description: json['description'] ?? '',
    isFavorite: json['is_favorite'] ?? false,
  );
}}