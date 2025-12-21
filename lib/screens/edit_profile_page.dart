import 'dart:io';
import 'package:bookingresidentialapartments/controller/edit_profile_controller.dart';
import 'package:bookingresidentialapartments/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});

  final EditProfileController controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 145, 199),
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
                        style: const TextStyle(
                            color: Color(0xFF0091C7)),
                      )),
                ),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
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
  }
}
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
        borderSide: const BorderSide(color: Color(0xFF0091C7), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF0091C7), width: 2),
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
      border: Border.all(color: const Color(0xFF0091C7), width: 1.5),
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
  required File? image,
  required String placeholderAsset,
}) {
  return Container(
    height: 100,
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFF0091C7), width: 1.5),
      borderRadius: BorderRadius.circular(12),
      color: Colors.grey[200],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: image != null
          ? Image.file(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
            )
          : Image.asset(
              placeholderAsset,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
    ),
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
      border: Border.all(color: const Color(0xFF0091C7), width: 1.5),
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
