import 'dart:io';

import 'package:bookingresidentialapartments/controller/auth/auth_controller.dart';
import 'package:bookingresidentialapartments/controller/core/language_controller.dart';
import 'package:bookingresidentialapartments/controller/navigation_controller.dart';
import 'package:bookingresidentialapartments/controller/core/theme_controller.dart';
import 'package:bookingresidentialapartments/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfilePage extends StatelessWidget {
   ProfilePage({super.key});
final UserController userController = Get.find<UserController>();
final ThemeController themeController = Get.find<ThemeController>();
final AuthController authController = Get.find<AuthController>();
final navController = Get.find<NavigationController>();
final LanguageController langController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    
    final theme = Theme.of(context);
    return Obx(() {
    final isOwner = navController.isOwnerMode.value;
    return Scaffold(
       appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
       backgroundColor: isOwner ?   Color.fromARGB(255, 95, 95, 95): theme.appBarTheme.backgroundColor,
        elevation: isOwner ? 0 : 4,
        title:  Text(
          'Profile'.tr,
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
       style: theme.textTheme.titleMedium,
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
            backgroundColor:  isOwner ? Color.fromARGB(255, 95, 95, 95) : const Color.fromARGB(255, 0, 145, 199),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            Get.toNamed('/editProfile');
          },
          child:  Text(
            'Edit Profile'.tr,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),

      const SizedBox(height: 30),
      const Divider(),

      //🌙 Dark Mode
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //      Text('Dark Mode'.tr, style: TextStyle(fontSize: 16)),
      //     Switch(
      //       value: themeController.isDark.value,
      //       onChanged: themeController.toggleTheme,
      //       activeThumbColor: Colors.blue,
      //     ),
      //   ],
      // ),
      Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      'Dark Mode'.tr,
      style: theme.textTheme.bodyLarge,
    ),
    Obx(() {
      return GestureDetector(
        onTap: () {
         themeController.toggleTheme(!themeController.isDark.value);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          width: 90,
          height: 40,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: themeController.isDark.value ? Colors.green :(isOwner ? Color.fromARGB(255, 95, 95, 95) : const Color.fromARGB(255, 0, 145, 199)),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            alignment:
                themeController.isDark.value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              
            ),
          ),
        ),
      );
    }),
  ],
),
       const SizedBox(height: 15),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      'Language'.tr,
      style: theme.textTheme.bodyLarge,
    ),
    Obx(() {
      final isArabic = langController.isArabic;

      return GestureDetector(
        onTap: () {
          langController.toggleLanguage(!isArabic);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          width: 90,
          height: 40,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isArabic ? Colors.green : (isOwner ? Color.fromARGB(255, 95, 95, 95) : const Color.fromARGB(255, 0, 145, 199)),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            alignment:
                isArabic ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  isArabic ? 'AR' : 'EN',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }),
  ],
),


      const SizedBox(height: 15),

      ListTile(
  contentPadding: const EdgeInsets.only(left: 14),
  title: Obx(() {
    final nav = Get.find<NavigationController>();
    return Text(
       nav.isOwnerMode.value ? 'Home'.tr : 'My Apartments'.tr,
    );
  }),
  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
  onTap: () {
    final nav = Get.find<NavigationController>();

    if (nav.isOwnerMode.value) {
      nav.switchToTenant(); // 👤
    } else {
      nav.switchToOwner(); // 🏠
    }
  },
),


      ListTile(
        contentPadding: const EdgeInsets.only(left: 14),
        title:  Text('Log Out'.tr),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: authController.confirmLogout,
      ),
    ],
  ),
)),
     
    );
    
  });
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

  // 2️⃣ صورة من السيرفر
  final imageUrl = avatar.startsWith('http')
      ? avatar
      : 'https://nonevil-emmalynn-inoperative.ngrok-free.dev/storage/$avatar';

  return Image.network(
    imageUrl,
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

}
