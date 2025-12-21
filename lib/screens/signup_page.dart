import 'dart:io';

import 'package:bookingresidentialapartments/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.put(SignUpController());

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SingleChildScrollView(
        child: Column(
          children: [
    Container(
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1689C5),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),

            const SizedBox(height: 20),

             const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Please provide your information to\ncreate account',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 24),

        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Your Name'),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Expanded(child: _inputField('First Name', onChanged: (v) => controller.firstName.value = v)),
                      const SizedBox(width: 12),
                      Expanded(child: _inputField('Last Name', onChanged: (v) => controller.lastName.value = v)),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Text('Phone Number'),
                  const SizedBox(height: 8),

                  _inputField(
                    'Your Phone Number', onChanged: (v) => controller.phone.value = v,
                    isNumber: true,
                  ),

                  const SizedBox(height: 16),
                  const Text('Birthday'),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Expanded(
                        child: _inputField('Day', isNumber: true),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _inputField('Month', isNumber: true),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _inputField('Year', isNumber: true),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Text('Personal Image                      Identity Image'),
                  const SizedBox(height: 8),

                  Row(
  children: [
    Expanded(
      child: Obx(() => GestureDetector(
            onTap: () =>
                controller.pickImage(isPersonal: true),
            child: _imagePickerBox(
              image: controller.personalImage.value,
            ),
          )),
    ),
    const SizedBox(width: 12),
    Expanded(
      child: Obx(() => GestureDetector(
            onTap: () =>
                controller.pickImage(isPersonal: false),
            child: _imagePickerBox(
              image: controller.identityImage.value,
            ),
          )),
    ),
  ],
),

                  const SizedBox(height: 16),
                  Text('Password', ),
                  const SizedBox(height: 8),

                  _inputField(
                    'Your Password',
                    onChanged: (v) => controller.password.value = v,
                    isPassword: true,
                  ),

                  const SizedBox(height: 12),

                  _inputField(
                    'Confirm Password',
                     onChanged: (v) => controller.confirmPassword.value = v,
                    isPassword: true,
                  ),

                  const SizedBox(height: 30),

                  // ---------- Sign Up Button ----------
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1689C5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                     
                      onPressed: controller.signUp,
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18,color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 22),
                      child: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Back to Log in',style: TextStyle(color: Colors.black),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  static Widget _inputField(
    String hint, {
    bool isPassword = false,
    bool isNumber = false,
    Function(String)? onChanged,
  }) {
    return TextField(
      obscureText: isPassword,
    onChanged: onChanged,
      keyboardType:
          isNumber ? TextInputType.number : TextInputType.text,

      inputFormatters: isNumber
          ? [FilteringTextInputFormatter.digitsOnly]
          : null,

      decoration: InputDecoration(
        hintText: hint,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF1689C5),
            width: 1.5,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF1689C5),
            width: 2,
          ),
        ),
      ),
    );
  }

 static Widget _imagePickerBox({File? image}) {
  return Container(
    height: 100,
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFF1689C5)),
      borderRadius: BorderRadius.circular(12),
      color: Colors.grey[200],
    ),
    child: image == null
        ? const Center(
            child: Icon(Icons.add,
                color: Color(0xFF1689C5), size: 40),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
  );
}
}