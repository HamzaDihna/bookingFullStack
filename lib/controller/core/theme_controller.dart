import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isDark = false.obs;

  void toggleTheme(bool value) {
    isDark.value = value;

    Get.changeTheme(
      value ? darkTheme : lightTheme,
    );
  }
}
final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.lightBlue,
    foregroundColor: Colors.white,
  ),
);
final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFF1E1E1E),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF0D47A1),
    foregroundColor: Colors.white,
  ),
  cardColor: const Color(0xFF2A2A2A),
);
