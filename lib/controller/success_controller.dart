import 'package:get/get.dart';

class SuccessController extends GetxController {
  final String message = 'Your account has been created.';
  
  void navigateToLogin() {
    Get.offAllNamed('/login');
  }
  
  void navigateToHome() {
    Get.offAllNamed('/home'); 
  }
}