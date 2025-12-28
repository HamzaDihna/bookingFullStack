import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessfulPageSignup extends StatelessWidget {
  const SuccessfulPageSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 232, 241, 245), 
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.blue,
                    size: 80,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                
                const Text(
                  'Successful!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700, 
                    color: Colors.blue,
                    letterSpacing: 0.5,
                  ),
                ),
                
                const SizedBox(height: 16),
                
               
                const Text(
                  'Your account has been',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                    height: 1.2,
                  ),
                ),
                
            
                const Text(
                  'created.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                    height: 1.2,
                  ),
                ),
                
                const SizedBox(height: 48),
                
       
                SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1689C5), 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), 
                      ),
                      elevation: 0, // بدون ظل
                      padding: EdgeInsets.zero,
                    ),
                    
                    onPressed: () {
                      Get.snackbar(
  'Success',
  'Account created successfully,awaiting admin approval.',
  snackPosition: SnackPosition.BOTTOM,
);

                      Get.offAllNamed('/login'); 
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}