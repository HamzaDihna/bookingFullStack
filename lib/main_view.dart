import 'package:bookingresidentialapartments/controller/auth_controller.dart';
import 'package:bookingresidentialapartments/controller/theme_controller.dart';
import 'package:bookingresidentialapartments/controller/user_controller.dart';
import 'package:bookingresidentialapartments/screens/add_apartment_page.dart';
import 'package:bookingresidentialapartments/screens/chat_page.dart';
import 'package:bookingresidentialapartments/screens/favorite_page.dart';
import 'package:bookingresidentialapartments/screens/home_page.dart';
import 'package:bookingresidentialapartments/screens/my_apartments_page.dart';
import 'package:bookingresidentialapartments/screens/profile_page.dart';
import 'package:bookingresidentialapartments/screens/saved_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/navigation_controller.dart';

class MainView extends StatelessWidget {
  MainView({super.key});

  final NavigationController navController =
      Get.put(NavigationController());

  final UserController userController = Get.put(UserController());
  final ThemeController themeController = Get.put(ThemeController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isOwner = navController.isOwnerMode.value;

      final pages = isOwner
          ? [
              MyApartmentsPage(),   // 🏠 واجهة المؤجر
              AddApartmentPage(),   // ➕ إضافة شقة
              ChatPage(),
              ProfilePage(),
            ]
          : [
              HomePage(),
              FavoritePage(),
              ChatPage(),
              SavedPage(),
              ProfilePage(),
            ];

      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              final slideAnimation = Tween<Offset>(
                begin: const Offset(0.1, 0),
                end: Offset.zero,
              ).animate(animation);

              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: slideAnimation,
                  child: child,
                ),
              );
            },
            child: SizedBox(
              key: ValueKey(
                '${isOwner}_${navController.currentIndex.value}',
              ),
              child: pages[navController.currentIndex.value],
            ),
          ),

          bottomNavigationBar: _buildBottomNav(isOwner),
        ),
      );
    });
  }

  /// 🔻 Bottom Nav حسب الوضع
  Widget _buildBottomNav(bool isOwner) {
    return BottomNavigationBar(
      currentIndex: navController.currentIndex.value,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      onTap: navController.changeIndex,
      items: isOwner
          ? [
              _navItem(Icons.home, 0),        // Home (Owner)
              _navItem(Icons.add, 1),         // ➕
              _navItem(Icons.chat, 2),
              _navItem(Icons.person, 3),
            ]
          : [
              _navItem(Icons.home, 0),
              _navItem(Icons.favorite_border, 1),
              _navItem(Icons.chat_bubble_outline, 2),
              _navItem(Icons.bookmark_border, 3),
              _navItem(Icons.person_outline, 4),
            ],
    );
  }

  BottomNavigationBarItem _navItem(IconData icon, int index) {
    final isSelected = navController.currentIndex.value == index;

    return BottomNavigationBarItem(
      label: '',
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue, width: 2),
          color: isSelected ? Colors.blue : Colors.transparent,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.blue,
        ),
      ),
    );
  }
}
