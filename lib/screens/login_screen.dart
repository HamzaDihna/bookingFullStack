
import 'package:bookingresidentialapartments/controller/auth/login_controller.dart';
import 'package:bookingresidentialapartments/controller/home/favorite_controller.dart';
import 'package:bookingresidentialapartments/helper/my_flutter_app_icons.dart';
import 'package:bookingresidentialapartments/screens/signup_page.dart';
import 'package:bookingresidentialapartments/widget/text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());
  final favoriteController = Get.find<FavoriteController>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 150),
          child: Center(
            child: Column(
              children: [

                Image.asset('assets/images/Group.png', width: 70),

                const SizedBox(height: 60),

                 Text(
                  'Welcome back!'.tr,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: 300,
                  child: TextFieldWidget(
                    hintText: 'Your Phone Number'.tr,
                    icon: MyFlutterApp.mobile,
                    isPhone: true,
                    controller: controller.phoneController,
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: 300,
                  child: TextFieldWidget(
                    hintText: 'Your Password'.tr,
                    icon: MyFlutterApp.lock,
                    isPassword: true,
                    controller: controller.passwordController,
                  ),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: 280,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      minimumSize: const Size(280, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: controller.login,
                    child:  Text('Login'.tr, style: TextStyle(fontSize: 18,color: Colors.white)),
                  ),
                ),
            

Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
     Text(
      "Don't have account?".tr,
      style: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    ),
    TextButton(
  onPressed: controller.goToSignUp,
  
  child:  Text(
    'Sign Up'.tr,
    style: TextStyle(
      
      fontSize: 16,
      color: Colors.blue,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.underline,
      decorationColor: Colors.blue, 
      decorationThickness: 1,   
         
    ),
  ),
),

  ],
),
           
              ],
            ),
          ),
        ),
      ),
    );
  }
}
