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
                // ✅ علامة الصح الدائرية (بنفس حجم الصورة)
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 232, 241, 245), // أخضر فاتح جداً
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.blue, // أخضر متوسط
                    size: 80,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // ✅ النص "Successful!" (بنفس الخط والحجم)
                const Text(
                  'Successful!',
                  style: TextStyle(
                    fontSize: 28, // حجم متوسط
                    fontWeight: FontWeight.w700, // ليس bold جداً
                    color: Colors.blue,
                    letterSpacing: 0.5,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // ✅ النص "Your account has been" (سطر أول)
                const Text(
                  'Your account has been,awaiting admin approval.',
                  style: TextStyle(
                    fontSize: 20, // حجم أصغر قليلاً
                    fontWeight: FontWeight.w400, // وزن عادي
                    color: Colors.black87,
                    height: 1.2,
                  ),
                ),
                
                // ✅ النص "created." (سطر ثاني)
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
                
                // ✅ زر "OK" (بنفس التصميم بالضبط)
                SizedBox(
                  width: 250,
                  height: 50, // ارتفاع متوسط
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1689C5), // نفس لون تطبيقك
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // زوايا أقل دائرية
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

                      Get.offAllNamed('/login'); // أو أي صفحة تريد
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600, // متوسط السمك
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