import 'package:bookingresidentialapartments/controller/booking_controller.dart';
import 'package:get/get.dart';
import '../controller/user_controller.dart';
import '../controller/theme_controller.dart';
import '../controller/auth_controller.dart';
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
