import 'package:bookingresidentialapartments/controller/user_controller.dart';
import 'package:bookingresidentialapartments/services/api_service.dart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;
  final rememberMe = false.obs;

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }

 Future<void> login() async {
  final phone = phoneController.text.trim();
  final password = passwordController.text.trim();

  if (phone.isEmpty || password.isEmpty) {
    Get.snackbar('Error', 'Fill all fields');
    return;
  }

  isLoading.value = true;

  try {
    final response = await ApiService.login(
      phone: phone,
      password: password,
    );

    final userController = Get.find<UserController>();
    userController.loginFromApi(
      userData: response['user'],
      token: response['token'],
    );

    Get.offAllNamed('/homepage');
  } catch (e) {
    Get.snackbar('Login Failed', e.toString(),
        backgroundColor: Colors.red, colorText: Colors.white);
  } finally {
    isLoading.value = false;
  }
}
goToSignUp() {
    Get.toNamed('/signup');
  }
  
  Future<void> autoLogin() async {
    final userController = Get.find<UserController>();
    
    userController.loadUserFromStorage();
    
    if (userController.isLoggedIn.value && userController.token.value.isNotEmpty) {
      // التحقق من صلاحية التوكن
      try {
        // await ApiService.validateToken(userController.token.value);
        Get.offAllNamed('/homepage');
      } catch (e) {
        userController.clearUser();
      }
    }
  }
}