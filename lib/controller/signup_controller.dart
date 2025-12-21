import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'user_controller.dart';

class SignUpController extends GetxController {
  

  final picker = ImagePicker();
RxBool isPickingImage = false.obs;

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
 void signUp() {
  if (firstName.value.trim().isEmpty ||
      lastName.value.trim().isEmpty ||
      phone.value.trim().isEmpty ||
      password.value.trim().isEmpty || 
      personalImage.value == null ||
      identityImage.value == null || confirmPassword.value.trim().isEmpty) {
        
    Get.defaultDialog(
      title: 'Error',
      middleText: 'Please fill all fields',
      textConfirm: 'OK',
      onConfirm:  Get.back, // بس يسكر
    );

    return;
  }
  if (password.value != confirmPassword.value) {
    Get.defaultDialog(
      title: 'Password Error',
      middleText: 'Password does not match Confirm Password',
      textConfirm: 'OK',
      onConfirm:  Get.back, // بس يسكر
    );
    return;
  }
  final userController = Get.find<UserController>();

  userController.setUserSignUp(
    firstName: firstName.value,
    lastName: lastName.value,
    phone: phone.value,
    password: password.value,
    confirmPassword: confirmPassword.value,
    avatar: personalImage.value!.path,
    identityImage: identityImage.value!.path,
  );

  // ⏳ انتظر Frame
  Future.delayed(const Duration(milliseconds: 200), () {
    Get.offAllNamed('/successfulSignup');
  });
}
}
