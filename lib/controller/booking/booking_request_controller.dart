import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BookingRequestController extends GetxController {
  final isLoading = false.obs;

  Future<void> sendBookingRequest({
    required String apartmentId,
    required DateTime start,
    required DateTime end,
  })
  
   async {
    isLoading.value = true;

    try {
      ///هنا لاحقًا API CALL
      /// await api.sendBookingRequest(...);

      await Future.delayed(const Duration(seconds: 2));

      Get.snackbar(
        'Request Sent',
        'Waiting for owner approval',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send booking request',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
