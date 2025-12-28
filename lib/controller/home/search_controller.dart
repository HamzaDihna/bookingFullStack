import 'package:bookingresidentialapartments/models/search_filter_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {

  final selectedGovernorate = 'The Governorate'.obs;
  final selectedCity = 'The City'.obs;
  final minPrice = 50.obs;
  final maxPrice = 100.obs;
  final selectedRooms = 'Anything'.obs;
  final hasWifi = 'Yes'.obs;
late TextEditingController minPriceCtrl;
late TextEditingController maxPriceCtrl;

@override
void onInit() {
  super.onInit();
  minPriceCtrl = TextEditingController(text: minPrice.value.toString());
  maxPriceCtrl = TextEditingController(text: maxPrice.value.toString());

  ever(minPrice, (val) {
    minPriceCtrl.text = val.toString();
  });

  ever(maxPrice, (val) {
    maxPriceCtrl.text = val.toString();
  });
}

  final List<String> governorates = [
    'The Governorate',
    'Damascus',
    'Aleppo',
    'Homs',
    'Latakia',
    'Hama',
    'Deir ez-Zor',
    'Raqqa',
    'Daraa',
    'Tartus',
    'Quneitra',
    'As-Suwayda',
    'Idlib',
    'Al-Hasakah',
    
  ];

  final List<String> cities = [
    'The City',
    'City Center',
    'North District',
    'South District',
    'East District',
    'West District',
  ];

  final List<String> roomOptions = [
    'Anything',
    '1',
    '2',
    '3',
    '4+',
  ];

  final List<String> wifiOptions = ['Yes', 'No'];

  
void performSearch() {
  final Map<String, dynamic> filters = {};

  if (selectedGovernorate.value != 'The Governorate') {
    filters['governorate'] = selectedGovernorate.value;
  }

  if (selectedCity.value != 'The City') {
    filters['city'] = selectedCity.value;
  }

  filters['minPrice'] = minPrice.value;
  filters['maxPrice'] = maxPrice.value;
  filters['rooms'] = selectedRooms.value;
  filters['wifi'] = hasWifi.value;

  Get.back(result: filters);
}




  void resetFilters() {
    selectedGovernorate.value = 'The Governorate';
    selectedCity.value = 'The City';
    minPrice.value = 50;
    maxPrice.value = 100;
    selectedRooms.value = 'Anything';
    hasWifi.value = 'Yes';
  }
}
