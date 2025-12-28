import 'package:bookingresidentialapartments/controller/booking/booking_controller.dart';
import 'package:get/get.dart';
import '../controller/user_controller.dart';
import '../controller/core/theme_controller.dart';
import '../controller/auth/auth_controller.dart';
import '../controller/navigation_controller.dart';

class AppBinding extends Bindings {
  
  @override
  void dependencies() {
    Get.put(UserController(), permanent: true);
    Get.put(ThemeController(), permanent: true);
    Get.put(AuthController(), permanent: true);
    Get.put(NavigationController(), permanent: true);
    Get.put(BookingController(), permanent: true);

  }
}
