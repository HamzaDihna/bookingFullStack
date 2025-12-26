import 'package:get/get.dart';

class NavigationController extends GetxController {
  final currentIndex = 0.obs;

  /// 🔁 هل المستخدم بواجهة المؤجر؟
  final isOwnerMode = false.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  /// 🏠 التحويل لواجهة المؤجر
  void switchToOwner() {
    isOwnerMode.value = true;
    currentIndex.value = 0; // الصفحة الرئيسية للمؤجر
  }

  /// 👤 الرجوع لواجهة المستأجر
  void switchToTenant() {
    isOwnerMode.value = false;
    currentIndex.value = 0; // Home للمستأجر
  }
}
