import 'package:bookingresidentialapartments/models/apartment_model.dart';
import 'package:get/get.dart';
import '../../services/api_service.dart.dart';

class FavoriteController extends GetxController {
  var favorites = <ApartmentModel>[].obs;
  var isLoading = false.obs;

   Future<void> loadFavorites() async {
    try {
      isLoading.value = true;

      final data = await ApiService.getFavorites();

      favorites.assignAll(
        data
            .map((item) {
              // 🔥 هون الحل
              final apartmentJson = item['apartment'];
              return ApartmentModel.fromJson(apartmentJson);
            })
            .toList(),
      );
    } catch (e) {
      print('❌ Load favorites error: $e');
    } finally {
      isLoading.value = false;
    }
  }
  void addFavorite(ApartmentModel apartment) {
    if (!favorites.any((a) => a.id == apartment.id)) {
      favorites.add(apartment);
    }
  }

  void removeFavorite(String id) {
    favorites.removeWhere((a) => a.id == id);
  }

  bool isFavorite(String id) {
    return favorites.any((a) => a.id == id);
  }
  Future<void> toggleFavorite(ApartmentModel apartment) async {
    try {
      final isFav = await ApiService.toggleFavorite(int.parse(apartment.id));

      if (isFav) {
        favorites.add(apartment);
      } else {
        favorites.removeWhere((a) => a.id == apartment.id);
      }
    } catch (e) {
      print('❌ Toggle favorite error: $e');
    }
  }
}
