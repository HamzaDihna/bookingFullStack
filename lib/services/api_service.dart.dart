import 'package:dio/dio.dart';
import 'dart:io';

class ApiService {
static const String _baseUrl = 'https://nonevil-emmalynn-inoperative.ngrok-free.dev/api/';

  static final Dio _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    headers: {
      'Accept': 'application/json',
    },
  ));

  // LOGIN
  static Future<Map<String, dynamic>> login({
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _dio.post('login', data: {
        'phone': phone,
        'password': password,
      });
      return response.data;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Login failed';
    }
  }
// أضف هذه الدالة داخل كلاس ApiService
static Future<List<dynamic>> getApartments(String token) async {
  try {
    final response = await _dio.get('apartments', 
      options: Options(headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      }),
    );
    // التحليل الصحيح للرد القادم من Laravel Paginate
    if (response.data != null && response.data['success'] == true) {
      // الـ Paginate يضع القائمة داخل response.data['data']['data']
      return response.data['data']['data'] as List<dynamic>;
    }
    return []; // نفترض أن الباك إند يرسل قائمة مباشرة
  } on DioException catch (e) {
    print("❌ API Error: ${e.response?.data}");
    throw e.response?.data['message'] ?? 'Failed to load apartments';
  }
}
  // REGISTER
 static Future<Map<String, dynamic>> register({
    required String name,
    required String phone,
    required String password,
    required String passwordConfirmation,
    File? profileImage,
    File? idImage,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'name': name,
        'phone': phone,
        'password': password,
        'password_confirmation': passwordConfirmation,
        if (profileImage != null)
          'profile_image': await MultipartFile.fromFile(profileImage.path),
        if (idImage != null)
          'id_image': await MultipartFile.fromFile(idImage.path),
      });

      final response = await _dio.post('register', data: formData);
      return response.data;
    } on DioException catch (e) {
      // التعديل هنا: طباعة الخطأ كامل بالـ Console عشان تفهمه
      print("❌ Laravel Error: ${e.response?.data}"); 
      
      // إذا كان هناك خطأ في المدخلات (Validation)
      if (e.response?.data['errors'] != null) {
        Map errors = e.response?.data['errors'];
        throw errors.values.first[0]; // بياخد أول رسالة خطأ (مثلاً: الهاتف مستخدم)
      }
      
      throw e.response?.data['message'] ?? 'فشل الاتصال بالسيرفر';
    }
  }}