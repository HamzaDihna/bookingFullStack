import 'package:bookingresidentialapartments/controller/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'filter_chip_widget.dart';

class FilterBar extends StatelessWidget {
  final HomeController controller;

  const FilterBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.isFiltering.value) return const SizedBox();

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(4),
        
    child: Row(
  children: [
    // 💰 Price Chip
    if (controller.activeFilters.containsKey('minPrice') &&
        controller.activeFilters.containsKey('maxPrice'))
      Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Chip(
          
          backgroundColor: Colors.white,
          label: Text(
            '\$${controller.activeFilters['minPrice']} - \$${controller.activeFilters['maxPrice']}',style: TextStyle(fontStyle: FontStyle.italic),
          ),
          deleteIcon: const Icon(Icons.close),
          onDeleted: () {
            controller.activeFilters.remove('minPrice');
            controller.activeFilters.remove('maxPrice');
            controller.clearFilters();
          },
        ),
      ),
    ...controller.activeFilters.entries.map((entry) {
      if (entry.key == 'minPrice' ||
          entry.key == 'maxPrice' ||
          entry.value == 'Anything' ||
          entry.value == 'The City' ||
          entry.value == 'The Governorate') {
        return const SizedBox();
      }

      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Chip(
          backgroundColor:Colors.white,
          label: Text(
            entry.key == 'wifi'
                ? 'Wifi'
                : entry.value.toString(),style: TextStyle(fontStyle: FontStyle.italic),
          ),
          deleteIcon: const Icon(Icons.close),
          onDeleted: () {
            controller.activeFilters.remove(entry.key);
            controller.applySearchFilters(
              Map<String, dynamic>.from(controller.activeFilters),
            );
          },
        ),
      );
    }).toList(),
  ],
),
  );
    });
  }
}

