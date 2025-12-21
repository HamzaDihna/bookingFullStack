import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_controller.dart';

class AuthController extends GetxController {
  void confirmLogout() {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Are you sure you want to logout?',
      textConfirm: 'Yes',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: logout,
    );
  }

  void logout() {
    final userController = Get.find<UserController>();

    userController.clearUser();

    Get.offAllNamed('login');
  }
}
