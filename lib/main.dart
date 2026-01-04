import 'package:bookingresidentialapartments/binding/app_binding.dart';
import 'package:bookingresidentialapartments/controller/auth/auth_controller.dart';
import 'package:bookingresidentialapartments/controller/booking/booking_controller.dart';
import 'package:bookingresidentialapartments/controller/core/language_controller.dart';
import 'package:bookingresidentialapartments/controller/core/translations.dart';
import 'package:bookingresidentialapartments/controller/home/favorite_controller.dart';
import 'package:bookingresidentialapartments/controller/navigation_controller.dart';
import 'package:bookingresidentialapartments/controller/core/theme_controller.dart';
import 'package:bookingresidentialapartments/controller/user_controller.dart';
import 'package:bookingresidentialapartments/main_view.dart';
import 'package:bookingresidentialapartments/screens/Login_screen.dart';
import 'package:bookingresidentialapartments/screens/add_apartment_page.dart';
import 'package:bookingresidentialapartments/screens/apartment_details_page.dart';
import 'package:bookingresidentialapartments/screens/booking_details_page.dart';
import 'package:bookingresidentialapartments/screens/edit_booking_page.dart';
import 'package:bookingresidentialapartments/screens/edit_profile_page.dart';
import 'package:bookingresidentialapartments/screens/getStarted_screen.dart';
import 'package:bookingresidentialapartments/screens/my_apartments_page.dart';
import 'package:bookingresidentialapartments/screens/notifications_page.dart';
import 'package:bookingresidentialapartments/screens/profile_page.dart';
import 'package:bookingresidentialapartments/screens/search_page.dart';
import 'package:bookingresidentialapartments/screens/select_date_page.dart';
import 'package:bookingresidentialapartments/screens/signup_page.dart';
import 'package:bookingresidentialapartments/screens/splash_screen.dart';
import 'package:bookingresidentialapartments/screens/successful_booking_page.dart';
import 'package:bookingresidentialapartments/screens/successful_signup.dart';
import 'package:bookingresidentialapartments/services/api_service.dart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(ThemeController());
  Get.put(UserController());
  final userController = Get.find<UserController>();
  userController.loadUserFromStorage();
  if (userController.token.value.isNotEmpty) {
    ApiService.setToken(userController.token.value);
  }
   Get.put(FavoriteController(), permanent: true);
  Get.put(AuthController());
Get.put(NavigationController(), permanent: true);
Get.put(BookingController(), permanent: true);
Get.put(LanguageController(), permanent: true);

runApp( bookingresidentialapartments());
}

class bookingresidentialapartments extends StatelessWidget {
   bookingresidentialapartments({super.key});
 final LanguageController langController =
        Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() => GetMaterialApp(
      initialBinding: AppBinding(),
      debugShowCheckedModeBanner: false,
   theme: ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF0091C7),
  scaffoldBackgroundColor: const Color(0xFFF5F7FA),
  cardColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF0091C7),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.black87),
    titleLarge: TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
    ),
  ),
),

darkTheme: ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF0091C7),
  scaffoldBackgroundColor: const Color(0xFF121212),
  cardColor: const Color(0xFF1E1E1E),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
    titleLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
),
translations: AppTranslations(),
  locale: Get.find<LanguageController>().locale.value,
  fallbackLocale: const Locale('en'),
  builder: (context, child) {
      return Directionality(
        textDirection: langController.isArabic
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: child!,
      );
    },

      themeMode:
          themeController.isDark.value ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
  getPages: [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/homepage', page: () => MainView()),
    GetPage(name: '/selectDate', page: () => SelectDatePage()),
    GetPage(name: '/getstarted', page: () => GetStarted()),
    GetPage(name: '/login', page: () =>  LoginScreen()),
    GetPage(name: '/details', page: () =>  ApartmentDetailsPage()),
   GetPage(name: '/signup', page: () => const SignUpPage()),
   GetPage(name: '/SearchPage', page: () =>  SearchPage()),
   GetPage(name: '/profile', page: () =>  ProfilePage()),

    GetPage(name: '/successfulSignup', page: () => const SuccessfulPageSignup()),
    GetPage(name: '/successfulBooking', page: () => const SuccessfulBookingPage()),
   GetPage( name: '/editProfile',page: () =>  EditProfilePage(),),   
  GetPage(name: '/signup', page: () =>  SignUpPage()),
  GetPage(name: '/bookingDetails',page: () => const BookingDetailsPage(),),
   GetPage(name: '/editBooking',page: () =>  EditBookingPage(),),
  GetPage(name: '/myApartments', page: () =>  MyApartmentsPage()),
  GetPage(name: '/addApartment', page: () =>  AddApartmentPage()),
  GetPage(
  name: '/notifications',
  page: () => NotificationsPage(),
),

  ],
    ));
  }
}
