import 'dart:io';
import 'dart:ui';
import 'package:bookingresidentialapartments/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../user_controller.dart';

class EditProfileController extends GetxController {
  final UserController userController = Get.find<UserController>();
  final ImagePicker picker = ImagePicker();
RxBool isPickingImage = false.obs;
  /// 🔤 Text
  late RxString firstName;
  late RxString lastName;
  late RxString phone;

  RxString oldPassword = ''.obs;
  RxString newPassword = ''.obs;
  RxString confirmPassword = ''.obs;

  /// 👁 Password visibility
  RxBool showPassword = false.obs;

  /// 🎂 Birthday
  RxnInt day = RxnInt();
  RxnInt month = RxnInt();
  RxnInt year = RxnInt();

  /// 📸 Images
  Rx<File?> personalImage = Rx<File?>(null);
  Rx<File?> identityImage = Rx<File?>(null);

  @override
void onInit() {
  super.onInit();

  firstName = userController.firstName.value.obs;
  lastName  = userController.lastName.value.obs;
  phone     = userController.phone.value.obs;
personalImage.value = null;
  identityImage.value = null;
 
  if (userController.birthday.value.isNotEmpty) {
    final parts = userController.birthday.value.split('/');
    if (parts.length == 3) {
      day.value = int.tryParse(parts[0]);
      month.value = int.tryParse(parts[1]);
      year.value = int.tryParse(parts[2]);
    }
  }
}

  /// 📷 Pick Image
  Future<void> pickImage(bool isPersonal) async {
  if (isPickingImage.value) return;

  isPickingImage.value = true;

  try {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    if (isPersonal) {
      personalImage.value = File(image.path);
    } else {
      identityImage.value = File(image.path);
    }
  } finally {
    isPickingImage.value = false;
  }
}

  /// 👁 Toggle password
  void togglePassword() {
    showPassword.toggle();
  }

  /// 💾 Save profile
  void saveProfile() {
    /// 🔴 Validation أساسي
    if (firstName.value.trim().isEmpty ||
        lastName.value.trim().isEmpty ||
        phone.value.trim().isEmpty) {
      _error('Please fill all required fields');
      return;
    }

    /// 🔐 Password validation
    if (newPassword.value.isNotEmpty ||
        confirmPassword.value.isNotEmpty) {
      if (oldPassword.value.isEmpty) {
        _error('Enter old password');
        return;
      }

      if (newPassword.value.length < 6) {
        _error('Password must be at least 6 characters');
        return;
      }

      if (newPassword.value != confirmPassword.value) {
        _error('Passwords do not match');
        return;
      }
    }

    /// ✅ Update
    userController.updateProfile(
      newFirstName: firstName.value.trim(),
      newLastName: lastName.value.trim(),
      newPhone: phone.value.trim(),
      newPassword:
          newPassword.value.isEmpty ? null : newPassword.value,
      newAvatar: personalImage.value?.path,
      newIdentityImage: identityImage.value?.path,
      newBirthday:
          day.value != null && month.value != null && year.value != null
              ? '${day.value}/${month.value}/${year.value}'
              : null,
    );

    Get.snackbar(
      'Success',
      'Profile updated successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0091C7),
      colorText: Colors.white,
    );
final navController = Get.find<NavigationController>();
  navController.changeIndex(4);
  Get.offAllNamed('/homepage');




  }

  /// 🔴 Error snackbar
  void _error(String msg) {
    Get.snackbar(
      'Error',
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.black,
    );
  }
}
