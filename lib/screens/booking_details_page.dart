import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/booking_model.dart';
import '../controller/booking_controller.dart';

class BookingDetailsPage extends StatelessWidget {
  const BookingDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final booking = Get.arguments as BookingModel;
    final apartment = booking.apartment;
    final bookingController = Get.find<BookingController>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
         title: const Text(
          'Details',
          style: TextStyle(color: Colors.white),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => Get.back(),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ),
      ),

      body: Stack(
        children: [
          /// 🔹 Image
          Image.asset(
            apartment.image,
            height: 360,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          /// 🔹 Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.55,
            maxChildSize: 0.9,
            builder: (_, controller) {
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title + Favorite
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            apartment.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(Icons.favorite,
                              color: Colors.red),
                        ],
                      ),

                      const SizedBox(height: 6),

                      /// Location
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 16, color: Colors.blue),
                          const SizedBox(width: 4),
                          Text(apartment.location),
                        ],
                      ),

                      const SizedBox(height: 16),

                      /// Price
                      Text(
                        '${apartment.price}\$',
                        style: const TextStyle(
                          fontSize: 26,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text('Per day'),

                      const SizedBox(height: 20),

                      /// Rooms + Wifi
                      Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius:
                              BorderRadius.circular(18),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _infoItem(
                                  'Rooms', '${apartment.rooms}'),
                            ),
                            Container(
                              height: 40,
                              width: 1,
                              color: Colors.grey,
                            ),
                            Expanded(
                              child: _infoItem(
                                'Free Wifi',
                                apartment.hasWifi ? 'Yes' : 'No',
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// Description
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(apartment.description),

                      const SizedBox(height: 30),

                      /// 🔥 Buttons Edit + Cancel
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // 👇 الخطوة القادمة
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: const Text('Edit',style: TextStyle(color: Colors.white),),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                bookingController.cancelBooking(
                                    booking.id);
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text('Cancel',style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _infoItem(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
