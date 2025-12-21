import 'dart:io';

import 'package:bookingresidentialapartments/controller/auth_controller.dart';
import 'package:bookingresidentialapartments/controller/navigation_controller.dart';
import 'package:bookingresidentialapartments/controller/theme_controller.dart';
import 'package:bookingresidentialapartments/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfilePage extends StatelessWidget {
   ProfilePage({super.key});
final UserController userController = Get.find<UserController>();
final ThemeController themeController = Get.find<ThemeController>();
final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 145, 199),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
  icon: const Icon(Icons.arrow_back, color: Colors.white),
  onPressed: () {
    final navController = Get.find<NavigationController>();
    navController.changeIndex(0); // 🏠 Home
  },
),

      ),
body: Obx(() => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 24),
  child: Column(
    children: [
      const SizedBox(height: 30),

      Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(255, 0, 145, 199),
        ),
     child: ClipOval(
  child: _buildAvatar(userController.avatar.value),
),


      ),

      const SizedBox(height: 16),

      /// 👤 Name
      Text(
        userController.fullName,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 4),

      Text(
        userController.phone.value,
        style: const TextStyle(color: Colors.grey),
      ),

      const SizedBox(height: 20),

      SizedBox(
        width: 160,
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 0, 145, 199),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            Get.toNamed('/editProfile');
          },
          child: const Text(
            'Edit Profile',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),

      const SizedBox(height: 30),
      const Divider(),

      /// 🌙 Dark Mode
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Dark Mode', style: TextStyle(fontSize: 16)),
          Switch(
            value: themeController.isDark.value,
            onChanged: themeController.toggleTheme,
            activeThumbColor: Colors.blue,
          ),
        ],
      ),

      const SizedBox(height: 20),

      ListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('My Apartments'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),

      ListTile(
        contentPadding: const EdgeInsets.only(left: 14),
        title: const Text('Log Out'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: authController.confirmLogout,
      ),
    ],
  ),
)),
     
    );
    
  }
  Widget _buildAvatar(String avatar) {
  // 1️⃣ ما في صورة
  if (avatar.isEmpty) {
    return Image.asset(
      'assets/images/imageAvatar.png',
      fit: BoxFit.cover,
      width: 100,
      height: 100,
    );
  }

  // 2️⃣ صورة من الإنترنت
  if (avatar.startsWith('http')) {
    return Image.network(
      avatar,
      fit: BoxFit.cover,
      width: 100,
      height: 100,
      errorBuilder: (_, __, ___) {
        return Image.asset(
          'assets/images/imageAvatar.png',
          fit: BoxFit.cover,
          width: 100,
          height: 100,
        );
      },
    );
  }

  // 3️⃣ صورة محلية
  return Image.file(
    File(avatar),
    fit: BoxFit.cover,
    width: 100,
    height: 100,
  );
}

}
