import 'package:bookingresidentialapartments/controller/home/favorite_controller.dart';
import 'package:bookingresidentialapartments/controller/navigation_controller.dart';
import 'package:bookingresidentialapartments/widget/apartment_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
        final theme = Theme.of(context);
    final controller = Get.find<FavoriteController>();
    final navController = Get.find<NavigationController>();
    return Obx(() {
final isOwner = navController.isOwnerMode.value;
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        backgroundColor:isOwner ? Color.fromARGB(255, 95, 95, 95) : theme.appBarTheme.backgroundColor,
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            final navController = Get.find<NavigationController>();
            navController.changeIndex(0); // 🏠 Home
          },
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.favorites.isEmpty) {
          return const Center(child: Text('No favorites yet'));
        }

        return ListView.builder(
          itemCount: controller.favorites.length,
          itemBuilder: (_, i) {
            return ApartmentCard(
              apartment: controller.favorites[i],
              isOwnerView: isOwner,
            );
          },
        );
      }),
    );
  }
    );}
}
