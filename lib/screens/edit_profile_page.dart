import 'dart:io';
import 'package:bookingresidentialapartments/controller/navigation_controller.dart';
import 'package:bookingresidentialapartments/controller/profile/edit_profile_controller.dart';
import 'package:bookingresidentialapartments/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});

  final EditProfileController controller = Get.put(EditProfileController());
final navController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
    final isOwner = navController.isOwnerMode.value;
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        backgroundColor:isOwner ? Color.fromARGB(255, 95, 95, 95) : const Color.fromARGB(255, 0, 145, 199),
        title: const Text(
          'Profile Edit',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 👤 Name
              const Text('Your Name'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _input(
                      'First Name',
                      onChanged: (v) => controller.firstName.value = v,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _input(
                      'Last Name',
                      onChanged: (v) => controller.lastName.value = v,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const Text('Phone Number'),
              const SizedBox(height: 8),
              _input(
                'Phone',
                isNumber: true,
                onChanged: (v) => controller.phone.value = v,
              ),

              const SizedBox(height: 16),
              const Text('Birthday'),
              const SizedBox(height: 8),
              Obx(() => Row(
                    children: [
                      Expanded(child: _dropdown('Day', 31,
                          controller.day, (v) => controller.day.value = v)),
                      const SizedBox(width: 8),
                      Expanded(child: _dropdown('Month', 12,
                          controller.month, (v) => controller.month.value = v)),
                      const SizedBox(width: 8),
                     Expanded(
  child: _yearDropdown('Year',controller.year,(v) => controller.year.value = v,),
),
     ],
                  )),

              const SizedBox(height: 16),
              const Text('Personal Image          Identity Image'),
              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: Obx(() => GestureDetector(
  onTap: () => controller.pickImage(true),
  child: _imageBox(
    image: controller.personalImage.value,
     serverImagePath: Get.find<UserController>().avatar.value,
    placeholderAsset: 'assets/images/imageAvatar.png',
  ),
)),

                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Obx(() => GestureDetector(
  onTap: () => controller.pickImage(false),
  child: _imageBox(
    image: controller.identityImage.value,
    serverImagePath: Get.find<UserController>().identityImage.value,
    placeholderAsset: 'assets/images/imageIdentity.png',
  ),
)),

                  ),
                ],
              ),

              const SizedBox(height: 16),
              const Text('Password'),
              const SizedBox(height: 8),

              Obx(() => _input(
                    'Old Password',
                    isPassword: true,
                    obscure: !controller.showPassword.value,
                    onChanged: (v) =>
                        controller.oldPassword.value = v,
                  )),

              const SizedBox(height: 12),
              Obx(() => _input(
                    'New Password',
                    isPassword: true,
                    obscure: !controller.showPassword.value,
                    onChanged: (v) =>
                        controller.newPassword.value = v,
                  )),

              const SizedBox(height: 12),
              Obx(() => _input(
                    'Confirm New Password',
                    isPassword: true,
                    obscure: !controller.showPassword.value,
                    onChanged: (v) =>
                        controller.confirmPassword.value = v,
                  )),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: controller.togglePassword,
                  child: Obx(() => Text(
                        controller.showPassword.value
                            ? 'Hide password'
                            : 'Show password',
                        style: TextStyle(
                            color:isOwner ? const Color.fromARGB(255, 95, 95, 95) : const Color.fromARGB(255, 0, 145, 199),),
                      )),
                ),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: isOwner ? Color.fromARGB(255, 95, 95, 95) : const Color.fromARGB(255, 0, 145, 199),
                      minimumSize: const Size(280, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  onPressed: () => controller.saveProfile(),
                  child: const Text('Edit Profile',
                      style:
                          TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  });}
}
final navController = Get.find<NavigationController>();
    final isOwner = navController.isOwnerMode.value;
Widget _input(
  String hint, {
  bool isPassword = false,
  bool isNumber = false,
  bool obscure = false,
  
  Function(String)? onChanged,
}) {
  return TextField(
    obscureText: isPassword ? obscure : false,
    onChanged: onChanged,
    keyboardType: isNumber ? TextInputType.number : TextInputType.text,
    inputFormatters:
        isNumber ? [FilteringTextInputFormatter.digitsOnly] : null,
    decoration: InputDecoration(
      hintText: hint,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: isOwner ? const Color.fromARGB(255, 95, 95, 95) : const Color.fromARGB(255, 0, 145, 199), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: isOwner ? const Color.fromARGB(255, 95, 95, 95) : const Color.fromARGB(255, 0, 145, 199), width: 2),
      ),
    ),
  );
}
Widget _dropdown(
  String hint,
  int max,
  RxnInt selected,
  Function(int?) onChanged,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      border: Border.all(color:isOwner ? const Color.fromARGB(255, 95, 95, 95) : const Color.fromARGB(255, 0, 145, 199), width: 1.5),
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
    ),
    child: DropdownButton<int>(
      value: selected.value,
      isExpanded: true,
      underline: const SizedBox(),
      hint: Text(hint),
      items: List.generate(
        max,
        (index) => DropdownMenuItem(
          value: index + 1,
          child: Text('${index + 1}'),
        ),
      ),
      onChanged: onChanged,
    ),
  );
}
Widget _imageBox({
  File? image,                
  required String serverImagePath,
  required String placeholderAsset,
}) {
  if (image != null) {
    return Image.file(
      image,
      fit: BoxFit.cover,
      width: double.infinity,
    );
  }

  if (serverImagePath.isNotEmpty) {
    return Image.network(
      'https://nonevil-emmalynn-inoperative.ngrok-free.dev/storage/$serverImagePath',
      fit: BoxFit.cover,
      width: double.infinity,
      errorBuilder: (_, __, ___) => Image.asset(
        placeholderAsset,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }

  return Image.asset(
    placeholderAsset,
    fit: BoxFit.cover,
    width: double.infinity,
  );
}
Widget _yearDropdown(
  String hint,
  RxnInt selected,
  Function(int?) onChanged,
) {
  final currentYear = DateTime.now().year;

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      border: Border.all(color: isOwner ? const Color.fromARGB(255, 95, 95, 95) : const Color.fromARGB(255, 0, 145, 199), width: 1.5),
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
    ),
    child: DropdownButton<int>(
      value: selected.value,
      isExpanded: true,
      underline: const SizedBox(),
      hint: Text(hint),
      items: List.generate(
        80, // عدد السنوات
        (index) {
          final year = currentYear - index;
          return DropdownMenuItem(
            value: year,
            child: Text(year.toString()),
          );
        },
      ),
      onChanged: onChanged,
    ),
  );
}
