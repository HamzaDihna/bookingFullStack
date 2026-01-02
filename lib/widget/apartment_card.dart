import 'package:bookingresidentialapartments/controller/home/favorite_controller.dart';
import 'package:bookingresidentialapartments/screens/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/apartment_model.dart';
import '../controller/home/home_controller.dart';

class ApartmentCard extends StatelessWidget {
  final ApartmentModel apartment;
final bool enableNavigation;
 final bool isOwnerView;
  const ApartmentCard({super.key, required this.apartment, this.enableNavigation = true, this.isOwnerView = false});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
  final favController = Get.find<FavoriteController>();

    return GestureDetector(
      onTap: enableNavigation ? () {
        Get.toNamed(
          '/details',
          arguments: apartment,
        );
      } : null,
      child: Hero(
        tag: apartment.id,
        child: Material(
          color: Colors.transparent, // 🔥 ضروري مع Hero
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔹 Image + Favorite
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          apartment.image,
                          height: 150,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
    return Image.asset(
      'assets/images/Group.png',
    
    );
  },
    fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    /// ❤️ Favorite
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: GestureDetector(
                        onTap: () {
                          controller.toggleFavorite(apartment.id);
                        },
                        child: Container(
                          
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                              ),
                            ],
                          ),
                            child: Icon(
                              apartment.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: apartment.isFavorite ? Colors.red : Colors.grey,
                              size: 20,
                             
                            ),
                          ),
                        ),
                      ),
                    
                  ],
                ),

                /// 🔹 Title
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
                  child: Text(
                    apartment.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                /// 🔹 Location
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color:  isOwnerView ? const Color.fromARGB(255, 95, 95, 95) : Colors.blueAccent,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        apartment.location,
                        style: TextStyle(
                          color: isOwnerView ? const Color.fromARGB(255, 95, 95, 95) : Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 4),

                /// 🔹 Rating + Price
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      /// ⭐ Rating
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < apartment.rating.round()
                                ? Icons.star
                                : Icons.star_border,
                            size: 26,
                            color: Colors.amber,
                          );
                        }),
                      ),

                      const Spacer(),

                      /// 💲 Price
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                apartment.price.toStringAsFixed(0),
                                style: TextStyle(
                                  color:  isOwnerView ? const Color.fromARGB(255, 95, 95, 95) : Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 34,
                                  height: 1,
                                ),
                              ),
                              Icon(
                                Icons.attach_money,
                                color:  isOwnerView ? const Color.fromARGB(255, 95, 95, 95) : Colors.blueAccent,
                                size: 28,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 17),
                            child: const Text(
                              'per day',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 6),

                /// 🔹 Rooms + Wifi
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.bed,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text('${apartment.rooms} Rooms'),

                      const SizedBox(width: 16),

                      if (apartment.hasWifi) ...[
                        Icon(
                          Icons.wifi,
                          size: 16,
                          color:  isOwnerView ? const Color.fromARGB(255, 95, 95, 95) : Colors.blue,
                        ),
                        const SizedBox(width: 4),
                        const Text('WiFi'),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
