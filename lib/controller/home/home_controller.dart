import 'package:bookingresidentialapartments/controller/home/favorite_controller.dart';
import 'package:bookingresidentialapartments/controller/user_controller.dart';
import 'package:bookingresidentialapartments/services/api_service.dart.dart';
import 'package:get/get.dart';
import '../../models/apartment_model.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  RxBool isFiltering = false.obs;
RxInt minPrice = 0.obs;
RxInt maxPrice = 1000.obs;
RxString city = 'The City'.obs;
RxString rooms = 'Anything'.obs;
RxString wifi = 'Yes'.obs;

RxMap<String, dynamic> activeFilters = <String, dynamic>{}.obs;
  RxList<ApartmentModel> allApartments = <ApartmentModel>[].obs;

  
  RxList<ApartmentModel> filteredApartments = <ApartmentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
fetchApartments();
    allApartments.addAll([
      ApartmentModel(
        id: '1',
        title: 'Harbour View Loft',
        location: 'America - Manzanillo',
        price: 100,
        rating: 4.5,
        image: 'assets/images/Group.png',
        rooms: 3,
        hasWifi: true,
        description:
      'A beautiful apartment with a stunning harbour view and modern design hamza!',
      ),
      ApartmentModel(
        id: '2',
        title: 'Sunrise Apartment',
        location: 'Germany - Manzanillo',
        price: 56,
        rating: 3.8,
        image: 'assets/images/Group.png',
        rooms: 2,
        hasWifi: false,
      description:
      'A beautiful apartment with a stunning harbour view and modern design.',
      ),
    ]);

    
    filteredApartments.assignAll(allApartments);
  }

  Future<void> fetchApartments() async {
    try {
      isLoading.value = true;
      
      // 1. الحصول على التوكن من UserController
      final userController = Get.find<UserController>();
      String token = userController.token.value;
      // 2. طلب البيانات من ApiService
      final List<dynamic> data = await ApiService.getApartments();

      // 3. تحويل البيانات القادمة لـ Models
      List<ApartmentModel> loadedApartments = data.map((json) {
        return ApartmentModel.fromJson(json);
      }).toList();

      allApartments.assignAll(loadedApartments);
      filteredApartments.assignAll(loadedApartments);

    } catch (e) {
      Get.snackbar("Error", "Could not load apartments: $e");
    } finally {
      isLoading.value = false;
    }
    
  }
 void applySearchFilters(Map<String, dynamic> filters) {
  activeFilters.assignAll(filters);
  isFiltering.value = true;

  filteredApartments.assignAll(
    allApartments.where((a) {
      final city = filters['city'];
      final minPrice = filters['minPrice'];
      final maxPrice = filters['maxPrice'];
      final rooms = filters['rooms'];
      final wifi = filters['wifi'];

      bool match = true;

      if (city != null && city != 'The City') {
        match &= a.location.contains(city);
      }

      if (minPrice != null && maxPrice != null) {
        match &= a.price >= minPrice && a.price <= maxPrice;
      }

      if (rooms != null && rooms != 'Anything') {
        if (rooms == '4+') {
          match &= a.rooms >= 4;
        } else {
          match &= a.rooms == int.tryParse(rooms);
        }
      }

      if (wifi != null) {
        match &= (wifi == 'Yes' ? a.hasWifi : !a.hasWifi);
      }

      return match;
    }).toList(),
  );
}


void clearFilters() {
  isFiltering.value = false;
  filteredApartments.assignAll(allApartments);
}

  void removeFilter(String filter) {
    activeFilters.remove(filter);

    if (activeFilters.isEmpty) {
      isFiltering.value = false;
      filteredApartments.assignAll(allApartments);
    }
  }

Future<void> toggleFavorite(String id) async {
  final favController = Get.find<FavoriteController>();

  final index =
      allApartments.indexWhere((a) => a.id == id);
  if (index == -1) return;

  final apartment = allApartments[index];

  // optimistic update
  apartment.isFavorite = !apartment.isFavorite;
  filteredApartments.refresh();

  try {
    final isFav =
        await ApiService.toggleFavorite(int.parse(id));

    apartment.isFavorite = isFav;
    filteredApartments.refresh();

    // 🔥 تحديث صفحة المفضلة مباشرة
    if (isFav) {
      favController.addFavorite(apartment);
    } else {
      favController.removeFavorite(apartment.id);
    }
  } catch (e) {
    apartment.isFavorite = !apartment.isFavorite;
    filteredApartments.refresh();
    Get.snackbar('Error', e.toString());
  }
}


}
