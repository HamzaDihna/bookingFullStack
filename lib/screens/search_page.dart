import 'package:bookingresidentialapartments/controller/navigation_controller.dart';
import 'package:bookingresidentialapartments/screens/edit_profile_page.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import '../controller/home/search_controller.dart';

class SearchPage extends StatelessWidget {
 final SearchController controller = Get.put(SearchController());

final navController = Get.find<NavigationController>();
  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
        return Obx(() {
          
    final isOwner = navController.isOwnerMode.value;
    return Scaffold(
      backgroundColor: Colors.white,
          appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        backgroundColor: isOwner ? Color.fromARGB(255, 95, 95, 95) : Colors.blue,
        title: const Text(
          'Search',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
  icon: const Icon(Icons.arrow_back, color: Colors.white),
  onPressed: () {
  Get.back();
  },
),

      ),
  body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 The Governorate
            _buildSectionTitle('The Governorate ①'),
            Obx(() => _buildDropdown(
  value: controller.selectedGovernorate.value,
  items: controller.governorates,
  onChanged: (value) =>
      controller.selectedGovernorate.value = value!,
)),

            const SizedBox(height: 24),

            // 🔹 The City
            _buildSectionTitle('The City ①'),
            Obx(() => _buildDropdown(
  value: controller.selectedCity.value,
  items: controller.cities,
  onChanged: (value) =>
      controller.selectedCity.value = value!,
)),

            const SizedBox(height: 24),

            // 🔹 Price Per Day
            _buildSectionTitle('Price Per Day ①'),
            const SizedBox(height: 8),
            _buildPriceSection(),
            const SizedBox(height: 24),

            // 🔹 Rooms
            _buildSectionTitle('Rooms ①'),
            const SizedBox(height: 8),
            _buildRoomOptions(),
            const SizedBox(height: 24),

            // 🔹 Free Wifi
            _buildSectionTitle('Free Wifi ①'),
            const SizedBox(height: 8),
            _buildWifiOptions(),
            const SizedBox(height: 40),

            // 🔹 Search Button
            _buildSearchButton(),
          ],
        ),
      ),
  );
        });
  }

  // عنوان القسم
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  // Dropdown
  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
          onChanged: onChanged,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  color: item == 'The Governorate' || item == 'The City'
                      ? Colors.grey[500]
                      : Colors.black87,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // قسم السعر
  Widget _buildPriceSection() {
    final navController = Get.find<NavigationController>();
    return Obx(() {
      final isOwner = navController.isOwnerMode.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // التسمية
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Text(
                  '\$${controller.minPrice.value} - \$${controller.maxPrice.value}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                )),
          ],
        ),
        const SizedBox(height: 12),

        // Slider المزدوج
        Obx(() => RangeSlider(
              values: RangeValues(
                controller.minPrice.value.toDouble(),
                controller.maxPrice.value.toDouble(),
              ),
              min: 0,
              max: 500,
              divisions: 50,
              onChanged: (values) {
    controller.minPrice.value = values.start.round();
    controller.maxPrice.value = values.end.round();
  },
              labels: RangeLabels(
                '\$${controller.minPrice.value}',
                '\$${controller.maxPrice.value}',
              ),
              activeColor:isOwner ? Color.fromARGB(255, 95, 95, 95) : Colors.blue,
              inactiveColor: Colors.grey[300],
            )),

        // Input Fields للسعر
        const SizedBox(height: 16),
        Row(
  children: [
    Expanded(
      child: _buildPriceInput(
        '\$',
        'Min',
        controller.minPriceCtrl,
        controller.minPrice,
      ),
    ),
    const SizedBox(width: 16),
    Expanded(
      child: _buildPriceInput(
        '\$',
        'Max',
        controller.maxPriceCtrl,
        controller.maxPrice,
      ),
    ),
  ],
),

      ],
    );
  });
  }

  // حقل إدخال السعر
 Widget _buildPriceInput(
  String prefix,
  String hint,
  TextEditingController controller,
  RxInt priceRx,
) {
  return Container(
    height: 50,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFFE0E0E0), width: 1.5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Text(prefix),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(border: InputBorder.none),
            onChanged: (value) {
              final v = int.tryParse(value);
              if (v != null) {
                priceRx.value = v;
              }
            },
          ),
        ),
      ],
    ),
  );
}

 Widget _buildRoomOptions() {
  final navController = Get.find<NavigationController>();

  return Obx(() {
    final isOwner = navController.isOwnerMode.value;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: controller.roomOptions.map((option) {
        final isSelected = controller.selectedRooms.value == option;

        return GestureDetector(
          onTap: () => controller.selectedRooms.value = option,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? (isOwner ? Colors.grey : const Color(0xFF1689C5))
                  : Colors.white,
              border: Border.all(
                color: isSelected
                    ? (isOwner ? Colors.grey : const Color(0xFF1689C5))
                    : const Color(0xFFE0E0E0),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              option,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      }).toList(),
    );
  });
}

 Widget _buildWifiOptions() {
  final navController = Get.find<NavigationController>();

  return Obx(() {
    final isOwner = navController.isOwnerMode.value;

    return Row(
      children: [
        _buildWifiOption(
          text: 'Yes',
          isSelected: controller.hasWifi.value == 'Yes',
          isOwner: isOwner,
        ),
        const SizedBox(width: 16),
        _buildWifiOption(
          text: 'No',
          isSelected: controller.hasWifi.value == 'No',
          isOwner: isOwner,
        ),
      ],
    );
  });
}


 Widget _buildWifiOption({
  required String text,
  required bool isSelected,
  required bool isOwner,
}) {
  return Expanded(
    child: GestureDetector(
      onTap: () => controller.hasWifi.value = text,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isSelected
              ? (isOwner ? Colors.grey : const Color(0xFF1689C5))
              : Colors.white,
          border: Border.all(
            color: isSelected
                ? (isOwner ? Colors.grey : const Color(0xFF1689C5))
                : const Color(0xFFE0E0E0),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    ),
  );
}

  // زر البحث
  Widget _buildSearchButton() {
  final navController = Get.find<NavigationController>();

  return Obx(() {
    final isOwner = navController.isOwnerMode.value;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: controller.performSearch,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isOwner ? const Color(0xFF5F5F5F) : const Color(0xFF1689C5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: const Text(
          'Search',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  });
}
}