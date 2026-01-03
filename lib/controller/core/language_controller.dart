import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class LanguageController extends GetxController {
  final _box = GetStorage();
  var locale = const Locale('en').obs;

  @override
  void onInit() {
    String? langCode = _box.read('lang');
    if (langCode != null) {
      locale.value = Locale(langCode);
      Get.updateLocale(locale.value);
    }
    super.onInit();
  }

  void toggleLanguage(bool isArabic) {
    locale.value = isArabic ? const Locale('ar') : const Locale('en');
    Get.updateLocale(locale.value);
    _box.write('lang', locale.value.languageCode);
  }

  bool get isArabic => locale.value.languageCode == 'ar';
}
