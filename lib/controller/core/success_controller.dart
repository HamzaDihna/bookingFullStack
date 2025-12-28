import 'package:get/get.dart';

class SuccessController extends GetxController {
 final String message;
SuccessController({required this.message});

  
  void navigateToLogin() {
    Get.offAllNamed('/login');
  }
  
  void navigateToHome() {
    Get.offAllNamed('/home'); 
  }
}
