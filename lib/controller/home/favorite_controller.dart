import 'package:bookingresidentialapartments/models/apartment_model.dart';
import 'package:bookingresidentialapartments/services/api_service.dart.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FavoriteController extends GetxController {
  var favorites = <ApartmentModel>[].obs;
  var isLoading = false.obs;


  Future<void> fetchFavorites() async {
    try {
      isLoading.value = true;

      final data = await ApiService.getFavorites();

      favorites.assignAll(
        data.map((e) {
          final apartmentJson = e['apartment'];
          apartmentJson['is_favorite'] = true;
          return ApartmentModel.fromJson(apartmentJson);
        }).toList(),
      );
    } finally {
      isLoading.value = false;
    }
  }
  
    void addFavorite(ApartmentModel apartment) {
    if (!favorites.any((a) => a.id == apartment.id)) {
      favorites.add(apartment);
    }
  }

  // 🔥 حذف مباشر
  void removeFavorite(String apartmentId) {
    favorites.removeWhere((a) => a.id == apartmentId);
  }
}
