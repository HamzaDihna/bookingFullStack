import 'package:bookingresidentialapartments/controller/auth/auth_controller.dart';
import 'package:bookingresidentialapartments/controller/core/theme_controller.dart';
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
final NavigationController navController = Get.find<NavigationController>();

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
              FavoritePage(),
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

          bottomNavigationBar: isOwner ? _buildOwnerBottomBar() : _buildBottomNav(false),
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
              _navItem(Icons.favorite_border, 1),
              _navItem(Icons.add, 2),         // ➕
              _navItem(Icons.chat, 3),
              _navItem(Icons.person, 4),
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
  Widget _ownerNavIcon(IconData icon, int index) {
  final isSelected = navController.currentIndex.value == index;

  return GestureDetector(
    onTap: () => navController.changeIndex(index),
    child: Icon(
      icon,
      size: 26,
      color: isSelected ? const Color.fromARGB(255, 95, 95, 95) : Colors.grey,
    ),
  );
}

  Widget _buildOwnerBottomBar() {
  return SizedBox(
    height: 80,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        /// 🔹 الخلفية الرمادية
        Container(
          height: 70,
          decoration: const BoxDecoration(
            color: Colors.white, // رمادي ثابت
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ownerNavIcon(Icons.home, 0),
              _ownerNavIcon(Icons.favorite_border, 1),
              const SizedBox(width: 48), // مكان زر +
              _ownerNavIcon(Icons.chat, 3),
              _ownerNavIcon(Icons.person, 4),
            ],
          ),
        ),

        /// ➕ زر الإضافة
        Positioned(
          bottom: 20,
          child: GestureDetector(
            onTap: () => navController.changeIndex(2),
            child: Container(
              height: 58,
              width: 58,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 95, 95, 95),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

}
