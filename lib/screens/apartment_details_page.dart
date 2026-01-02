import 'package:bookingresidentialapartments/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/apartment_model.dart';

class ApartmentDetailsPage extends StatelessWidget {
   ApartmentDetailsPage({super.key});
final navController = Get.find<NavigationController>();
  @override
  Widget build(BuildContext context) {
final apartment = Get.arguments as ApartmentModel?;
if (apartment == null) {
    return const Scaffold(
      body: Center(
        child: Text('No apartment data'),
      ),
    );
  }

   return Obx(() {
    final isOwner = navController.isOwnerMode.value;
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
          Hero(
            tag: apartment.id,
            child: Stack(
              children: [
      AspectRatio(
  aspectRatio: 16 / 9, // أو 4 / 3
  child: Image.network(
    apartment.image,
    width: double.infinity,
    fit: BoxFit.contain, // 👈 لا قصّ
    errorBuilder: (_, __, ___) {
      return Image.asset(
        'assets/images/Group.png',
        fit: BoxFit.contain,
      );
    },
  ),
),

                Container(
                  height: 365,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

            DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.55,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            apartment.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            apartment.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

     Row(
                        children: [
                          Icon(Icons.location_on,
                              size: 16, color:isOwner ? const Color.fromARGB(255, 95, 95, 95) : Colors.blue,),
                          const SizedBox(width: 4),
                          Text(
                            apartment.location,
                            style:  TextStyle(color: isOwner ? Color.fromARGB(255, 95, 95, 95) : Colors.blue,),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                        Text(
                        '${apartment.price}\$',
                        style:  TextStyle(
                          fontSize: 26,
                          color:isOwner ? Color.fromARGB(255, 95, 95, 95) : Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text('Per day'),

                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _featureItem(
                                icon: Icons.bed,
                                title: 'Rooms',
                                value: '${apartment.rooms}',
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 1,
                              color: Colors.grey,
                            ),
                            Expanded(
                              child: _featureItem(
                                icon: Icons.wifi,
                                title: 'Wifi',
                                value:
                                    apartment.hasWifi ? 'Yes' : 'No',
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children:
                                List.generate(5, (index) {
                              return Icon(
                                index < apartment.rating.round()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 26,
                              );
                            }),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.chat,
                                color: Colors.white),
                            label: const Text(
                              'Chat with owner',
                              style:
                                  TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:isOwner ? Color.fromARGB(255, 95, 95, 95) : Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        apartment.description,
                        style:
                            const TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 24),

                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Get.back(),
                              child: const Text('Exit'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(
                                backgroundColor:isOwner ? Color.fromARGB(255, 95, 95, 95) : Colors.blue,
                              ),
                              onPressed: () {
                                Get.toNamed('/selectDate',
                                    arguments: apartment);
                              },
                              child: const Text(
                                'Booking',
                                style: TextStyle(
                                    color: Colors.white),
                              ),
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
  });
  }

  Widget _featureItem(
    
    {
    
    required IconData icon,
    required String title,
    required String value,
  }) {
    final navController = Get.find<NavigationController>();
    return Obx(() {
      final isOwner = navController.isOwnerMode.value;
    return Column(
      children: [
        Icon(icon, color: isOwner ? Color.fromARGB(255, 95, 95, 95) : Colors.blue, size: 30),
        const SizedBox(height: 6),
        Text(title,
            style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  });}
}