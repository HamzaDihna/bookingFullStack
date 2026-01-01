import 'package:get/get.dart';
import '../../models/apartment_model.dart';

class OwnerApartmentsController extends GetxController {
  RxList<ApartmentModel> apartments = <ApartmentModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchApartments();
    super.onInit();
  }

  void addApartment(ApartmentModel apartment) {
    apartments.insert(0, apartment);
  }
  void fetchApartments() async {
    isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 600)); // mock

    //apartments.value = demoApartments; // مؤقتاً

    isLoading.value = false;
  }

  void deleteApartment(int id) {
    apartments.removeWhere((a) => a.id == id);
  }
}
