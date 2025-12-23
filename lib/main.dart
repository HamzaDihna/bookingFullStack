import 'package:bookingresidentialapartments/binding/app_binding.dart';
import 'package:bookingresidentialapartments/controller/auth_controller.dart';
import 'package:bookingresidentialapartments/controller/booking_controller.dart';
import 'package:bookingresidentialapartments/controller/navigation_controller.dart';
import 'package:bookingresidentialapartments/controller/theme_controller.dart';
import 'package:bookingresidentialapartments/controller/user_controller.dart';
import 'package:bookingresidentialapartments/main_view.dart';
import 'package:bookingresidentialapartments/screens/Login_screen.dart';
import 'package:bookingresidentialapartments/screens/apartment_details_page.dart';
import 'package:bookingresidentialapartments/screens/booking_details_page.dart';
import 'package:bookingresidentialapartments/screens/edit_booking_page.dart';
import 'package:bookingresidentialapartments/screens/edit_profile_page.dart';
import 'package:bookingresidentialapartments/screens/getStarted_screen.dart';
import 'package:bookingresidentialapartments/screens/profile_page.dart';
import 'package:bookingresidentialapartments/screens/search_page.dart';
import 'package:bookingresidentialapartments/screens/select_date_page.dart';
import 'package:bookingresidentialapartments/screens/signup_page.dart';
import 'package:bookingresidentialapartments/screens/splash_screen.dart';
import 'package:bookingresidentialapartments/screens/successful_booking_page.dart';
import 'package:bookingresidentialapartments/screens/successful_signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  
  Get.put(ThemeController());
  Get.put(UserController());
  Get.put(AuthController());
Get.put(NavigationController(), permanent: true);
Get.put(BookingController(), permanent: true);

runApp( bookingresidentialapartments());
}

class bookingresidentialapartments extends StatelessWidget {
   bookingresidentialapartments({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() => GetMaterialApp(
      initialBinding: AppBinding(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode:
          themeController.isDark.value ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
  getPages: [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/homepage', page: () => MainView()),
    GetPage(name: '/selectDate', page: () => SelectDatePage()),
    GetPage(name: '/getstarted', page: () => GetStarted()),
    GetPage(name: '/login', page: () =>  LoginScreen()),
    GetPage(name: '/details', page: () => const ApartmentDetailsPage()),
   GetPage(name: '/signup', page: () => const SignUpPage()),
   GetPage(name: '/SearchPage', page: () =>  SearchPage()),
   GetPage(name: '/profile', page: () =>  ProfilePage()),
   
    GetPage(name: '/successfulSignup', page: () => const SuccessfulPageSignup()),
    GetPage(name: '/successfulBooking', page: () => const SuccessfulBookingPage()),
   GetPage( name: '/editProfile',page: () =>  EditProfilePage(),),   
  GetPage(name: '/signup', page: () =>  SignUpPage()),
  GetPage(name: '/bookingDetails',page: () => const BookingDetailsPage(),),
   GetPage(name: '/editBooking',page: () =>  EditBookingPage(),),

  ],
    ));
  }
}
