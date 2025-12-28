import 'dart:io';
import 'package:bookingresidentialapartments/services/api_service.dart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../user_controller.dart';

class SignUpController extends GetxController {
  

  final picker = ImagePicker();
RxBool isPickingImage = false.obs;
final isLoading = false.obs;
  // ---------- بيانات ----------
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString phone = ''.obs;
  RxString password = ''.obs;
RxString confirmPassword = ''.obs;
RxBool showPassword = false.obs;
RxBool showConfirmPassword = false.obs;

  Rx<File?> personalImage = Rx<File?>(null);
  Rx<File?> identityImage = Rx<File?>(null);

  /// اختيار صورة
  Future<void> pickImage({required bool isPersonal}) async {
  if (isPickingImage.value) return; // ⛔ منع التكرار

  isPickingImage.value = true;

  try {
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    if (isPersonal) {
      personalImage.value = File(image.path);
    } else {
      identityImage.value = File(image.path);
    }
  } finally {
    isPickingImage.value = false; // 🔓 فتح القفل
  }
}

  /// Sign Up (جاهز للباك)
 Future<void> signUp() async {
  if (password.value != confirmPassword.value) {
    Get.snackbar('Error', 'Passwords do not match');
    return;
  }

  isLoading.value = true;

  try {
    final response = await ApiService.register(
      name: '${firstName.value} ${lastName.value}',
      phone: phone.value,
      password: password.value,
      passwordConfirmation: confirmPassword.value,
      profileImage: personalImage.value,
      idImage: identityImage.value,
    );

    Get.snackbar('Success', response['message']);
    Future.delayed(const Duration(milliseconds: 200), () {
    Get.offAllNamed('/successfulSignup');
  });
  } catch (e) {
    Get.snackbar('Error', e.toString());
  } finally {
    isLoading.value = false;
  }
}
}