import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_controller.dart';

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

    // 🔴 تحقق من البيانات
    if (phone.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    if (phone.length < 10) {
      Get.snackbar('Error', 'Phone must be at least 10 digits');
      return;
    }

    isLoading.value = true;

    try {
      // 🔥 محاكاة اتصال API
      await Future.delayed(const Duration(seconds: 2));

      // ⚠️ في التطبيق الحقيقي:
      // final response = await ApiService.login(phone, password);
      // final userData = response.data['user'];
      // final token = response.data['token'];

      // ✅ بيانات وهمية من الـ API
      final mockApiResponse = {
        'success': true,
        'user': {
          'firstName': 'user',
          'lastName': 'front',
          'phone': phone,
          'avatar': 'https://example.com/avatar.png',
          'birthday': '15/05/1990',
        },
        'token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
      };

      final userController = Get.find<UserController>();

     
      userController.loginFromApi(
        userData: mockApiResponse['user'] as Map<String, dynamic>,
        token: mockApiResponse['token'] as String,
      );
      userController.printUserInfo();

     
      Get.snackbar(
        'Welcome ${userController.fullName}!',
        'Login successful',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );

      
      Get.offAllNamed('/homepage');

    } catch (e) {
      Get.snackbar(
        'Error',
        'error number or password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }

  }

void goToSignUp() {
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