import 'package:bookingresidentialapartments/widget/owner_apartment_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../widget/filter_bar.dart';

class MyApartmentsPage extends StatelessWidget {
  MyApartmentsPage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        backgroundColor: const Color.fromARGB(250, 0, 145, 199),
        title: const Text(
          'My Apartments',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          /// 🔍 Search (نفس Home)
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () async {
              final result = await Get.toNamed('/SearchPage');
              if (result != null && result is Map<String, dynamic>) {
                controller.applySearchFilters(result);
              }
            },
          ),

          /// ➕ Add Apartment
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Get.toNamed('/addApartment');
            },
          ),
        ],
      ),

      body: Column(
        children: [
          /// 🔹 Filter Bar (نفس Home)
          FilterBar(controller: controller),

          /// 🔹 List
          Expanded(
            child: Obx(() {
              if (controller.filteredApartments.isEmpty) {
                return const Center(
                  child: Text(
                    'No apartments yet',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                itemCount: controller.filteredApartments.length,
                itemBuilder: (context, index) {
                  return OwnerApartmentCard(
                    apartment: controller.filteredApartments[index],
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
