import 'package:bookingresidentialapartments/services/api_service.dart.dart';
import 'package:get/get.dart';
import '../../models/booking_model.dart';


class OwnerBookingController extends GetxController {
  final bookings = <BookingModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchOwnerBookings();
    super.onInit();
  }

  Future<void> fetchOwnerBookings() async {
    try {
      isLoading.value = true;
final res = await ApiService.get('owner/bookings');

final List list = res['data']; // 🔥 مهم

bookings.assignAll(
  list.map((e) => BookingModel.fromJson(e)).toList(),
);

    } finally {
      isLoading.value = false;
    }
  }

  Future<void> approve(String id) async {
    await ApiService.post('bookings/$id/approve');
    fetchOwnerBookings();
  }

  Future<void> reject(String id) async {
    await ApiService.post('bookings/$id/reject');
    fetchOwnerBookings();
  }
}
