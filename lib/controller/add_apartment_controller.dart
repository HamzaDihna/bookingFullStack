import 'dart:io';
import 'package:bookingresidentialapartments/controller/home/home_controller.dart';
import 'package:bookingresidentialapartments/controller/owner_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/apartment_model.dart';
import '../../services/api_service.dart.dart';


class AddApartmentController extends GetxController {
  final ImagePicker picker = ImagePicker();

  Rx<File?> image = Rx<File?>(null);
  RxString title = ''.obs;
  RxString governorate = ''.obs;
RxString city = ''.obs;
RxString pricePerNight = ''.obs;
RxInt bedrooms = 0.obs;
  RxBool hasWifi = true.obs;
  RxBool isLoading = false.obs;
RxString description = ''.obs;
  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      image.value = File(picked.path);
    }
  }

  bool get isValid =>
     image.value != null &&
    title.value.isNotEmpty &&
    governorate.value.isNotEmpty &&
    city.value.isNotEmpty &&
    description.value.isNotEmpty &&
    pricePerNight.value.isNotEmpty &&
    bedrooms.value > 0;

  Future<void> addApartment() async {
    
    if (!isValid) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    isLoading.value = true;

    try {
      final response = await ApiService.addApartment(
        title: title.value,
        governorate: governorate.value,
        city: city.value,
        pricePerNight: double.parse(pricePerNight.value),
        bedrooms: bedrooms.value,
        hasWifi: hasWifi.value,
        description: description.value, 
        image: image.value!,
        
      );
      print('🧪 FULL RESPONSE = $response');
      print("🔥 ADD APARTMENT RESPONSE: $response");

     final apartmentJson =
    response['data'] ??
    response['apartment'] ??
    response;
print('🧪 APARTMENT JSON = $apartmentJson');
print('🧪 IMAGES = ${apartmentJson['images']}');
print('🧪 MAIN IMAGE = ${apartmentJson['main_image']}');

final apartment = ApartmentModel.fromJson(apartmentJson);
final fixedApartment = ApartmentModel(
  id: apartment.id,
  title: apartment.title,
  location: apartment.location,
  price: apartment.price,
  rating: apartment.rating,
  image: apartment.image,
  rooms: apartment.rooms,
  hasWifi: hasWifi.value, // 🔥 هون الحل
  description: apartment.description,
  isFavorite: apartment.isFavorite,
);

      /// 🏠 تحديث Home
      Get.find<HomeController>().allApartments.insert(0, fixedApartment);
      Get.find<HomeController>().filteredApartments.insert(0, fixedApartment);

      /// 🏢 تحديث My Apartments
      Get.find<OwnerApartmentsController>()
          .apartments
          .insert(0, fixedApartment);

      Get.back();
      Get.snackbar('Success', 'Apartment added successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
