import 'package:bookingresidentialapartments/controller/home/home_controller.dart';
import 'package:bookingresidentialapartments/widget/apartment_card.dart';
import 'package:bookingresidentialapartments/widget/filter_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
        final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
         backgroundColor: theme.appBarTheme.backgroundColor,
        title:  Text(
          'Home'.tr,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
         IconButton(
  icon: const Icon(Icons.search, color: Colors.white),
  onPressed: () async {
  final result = await Get.toNamed('/SearchPage');

  if (result != null && result is Map<String, dynamic>) {
    controller.applySearchFilters(result);
  }
},
),


        ],
      ),

      body: Column(
        children: [
         FilterBar(controller: controller),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
    return const Center(child: CircularProgressIndicator()); // شكل التحميل
  }
              return Column(
    children: [
      FilterBar(controller: controller),
      Expanded(
        child: controller.filteredApartments.isEmpty
            ? const Center(child: Text("No apartments found")):ListView.builder(
                itemCount: controller.filteredApartments.length,
                itemBuilder: (context, index) {
                  return ApartmentCard(
                    apartment: controller.filteredApartments[index],
                  );
                },
              ),
      ),],);
            }),
          ),
        ],
      ),
    );
  }
}
