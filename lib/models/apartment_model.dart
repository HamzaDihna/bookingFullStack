class ApartmentModel {
  final String id;
  final String title;
  final String location;
  final double price;
  final double rating;
  final String image;
   bool isFavorite;
  final int rooms;
  final bool hasWifi;
final String description;
  ApartmentModel({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.rating,
    required this.image,
    this.isFavorite = false,
     this.rooms=0,
       //لا تنسئ تعمل required عند الربط في الكونستركتور
    required this.hasWifi,
    required this.description,
  });
}
// factory ApartmentModel.fromJson(Map<String, dynamic> json) {
//   return ApartmentModel(
//     id: json['id'],
//     title: json['title'],
//     location: json['location'],
//     price: (json['price'] as num).toDouble(),
//     rating: (json['rating'] as num).toDouble(),
//     image: json['image'] ?? '',
//     rooms: json['rooms'] ?? 0,
//     hasWifi: json['hasWifi'] ?? false,
//     isFavorite: json['isFavorite'] ?? false,
//   );
// }
