import 'package:bookingresidentialapartments/controller/add_apartment_controller.dart';
import 'package:bookingresidentialapartments/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AddApartmentPage extends StatelessWidget {
  final controller = Get.put(AddApartmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        backgroundColor:  Color.fromARGB(255, 95, 95, 95),

        title: Text(
          'Add Apartment'.tr,
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
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              GestureDetector(
                onTap: controller.pickImage,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: controller.image.value == null
                      ? const Center(child: Icon(Icons.add, size: 40))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            controller.image.value!,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 16),
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Apartment Name'.tr, style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            const SizedBox(height: 2),
              _field('Apartment Name'.tr, (v) => controller.title.value = v),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Apartment Location'.tr, style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            const SizedBox(height: 2),
             _field('Governorate'.tr, (v) => controller.governorate.value = v),
              _field('City'.tr, (v) => controller.city.value = v),
                            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Description'.tr, style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              _field( 'Description'.tr,(v) => controller.description.value = v,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Price Per Day'.tr, style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            const SizedBox(height: 2),
            _field('Price Per Day'.tr,(v) => controller.pricePerNight.value = v, isNumber: true,),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Rooms'.tr, style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              Wrap(
                spacing: 10,
                children: [1, 2, 3, 4].map((r) {
                  return ChoiceChip(
                    label: Text(r == 4 ? '4+' : '$r'),
                    selected: controller.bedrooms.value == r,
                    onSelected: (_) => controller.bedrooms.value = r,
                  );
                }).toList(),
              ),

              const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text('Free Wi-Fi'.tr, style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              const SizedBox(height: 2),
              Row(
                children: [
                  _wifi(controller, true),
                  const SizedBox(width: 12),
                  _wifi(controller, false),
                ],
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: 250,
                height: 48,
                child: ElevatedButton(
                  onPressed: controller.addApartment,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Color.fromARGB(255, 95, 95, 95),
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      :  Text('Add'.tr,textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(String hint, Function(String) onChanged,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        keyboardType:
            isNumber ? TextInputType.number : TextInputType.text,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  Widget _wifi(AddApartmentController c, bool yes) {
    return Expanded(
      child: Obx(() => ElevatedButton(
            onPressed: () => c.hasWifi.value = yes,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
              backgroundColor:
                  c.hasWifi.value == yes ? Colors.grey[600] : Colors.grey[300],
            ),
            child: Text(yes ? 'Yes'.tr : 'No'.tr,
                style: TextStyle(
                  color: c.hasWifi.value == yes ? Colors.white : Colors.black,
                )),
          )),
    );
  }
}
