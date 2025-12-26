import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/apartment_model.dart';

class OwnerApartmentCard extends StatelessWidget {
  final ApartmentModel apartment;

  const OwnerApartmentCard({
    super.key,
    required this.apartment,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: apartment.id,
      child: Material(
        color: Colors.transparent,
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

              /// 🔹 Image
              Padding(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    apartment.image,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
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
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      apartment.location,
                      style: const TextStyle(color: Colors.blueAccent),
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
                              style: const TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 34,
                                height: 1,
                              ),
                            ),
                            const Icon(
                              Icons.attach_money,
                              color: Colors.blueAccent,
                              size: 28,
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 17),
                          child: Text(
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
                    const Icon(Icons.bed, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text('${apartment.rooms} Rooms'),

                    const SizedBox(width: 16),

                    if (apartment.hasWifi) ...[
                      const Icon(Icons.wifi, size: 16, color: Colors.blue),
                      const SizedBox(width: 4),
                      const Text('WiFi'),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 12),

              /// 🔹 OWNER ACTIONS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    /// ✏️ Edit
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Get.toNamed(
                            '/editApartment',
                            arguments: apartment,
                          );
                        },
                        icon: const Icon(Icons.edit, size: 18, color: Colors.white),
                        label: const Text('Edit', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    /// 🗑 Delete
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Get.defaultDialog(
                            title: 'Delete Apartment',
                            middleText:
                                'Are you sure you want to delete this apartment?',
                            textConfirm: 'Delete',
                            textCancel: 'Cancel',
                            confirmTextColor: Colors.white,
                            onConfirm: () {
                              Get.back();
                              // TODO: controller.deleteApartment(apartment.id)
                            },
                          );
                        },
                        icon: const Icon(Icons.delete, size: 18, color: Colors.white),
                        label: const Text('Delete', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
