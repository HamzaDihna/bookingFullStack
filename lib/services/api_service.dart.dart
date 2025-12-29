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
static void setToken(String token) {
  _dio.options.headers['Authorization'] = 'Bearer $token';
}
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
      if (e.response?.data is Map) {
      return Future.error(e.response?.data['message'] ?? 'Login failed');
    } else {
      return Future.error(e.response!.data.toString());
    }
    }
    
  }
  
// أضف هذه الدالة داخل كلاس ApiService
static Future<List<dynamic>> getApartments() async {
  try {
    final response = await _dio.get('apartments', 
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
static Future<bool> editBooking({
  required String bookingId,
  required String startDate,
  required String endDate,
}) async {
  try {
    final response = await _dio.put(
      'bookings/$bookingId',
      data: {
        'start_date': startDate,
        'end_date': endDate,
      },
    );
    return response.statusCode == 200;
  } on DioException catch (e) {
    throw e.response?.data['message'] ?? 'Failed to edit booking';
  }
}

static Future<bool> cancelBooking(String bookingId) async {
    try {
      final response = await _dio.post('bookings/$bookingId/cancel');
      return response.statusCode == 200;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'فشل في إلغاء الحجز';
    }
  }
static Future<bool> createBooking({
    required int apartmentId, 
    required String startDate, 
    required String endDate
  }) async {
    try {
      final response = await _dio.post('bookings', 
        data: {
          'apartment_id': apartmentId,
          'start_date': startDate,
          'end_date': endDate,
        },
      
      );
      return response.statusCode == 201 || response.statusCode == 200;
    } on DioException catch (e) {
       print("❌ Create Booking Error: ${e.response?.data}");
       throw e.response?.data['message'] ?? 'فشل في إرسال طلب الحجز';
    }
  }
// 1. جلب حجوزات المستخدم (المستأجر)
  static Future<List<dynamic>> getMyBookings(String type) async {
    try {
      // ملاحظة: يجب أن تحصل على الـ token المخزن عندك (مثلاً من GetStorage أو SharedPreferences)
      // سأفترض هنا أنك تمرره أو تجلبه بطريقة ما، لكن للتبسيط الآن سأضعه كخيار
      final response = await _dio.get('bookings', 
        queryParameters: {'type': type},
      
      );

      if (response.data != null && response.data['success'] == true) {
        return response.data['data'] as List<dynamic>;
      }
      return [];
    } on DioException catch (e) {
      print("❌ Get Bookings Error: ${e.response?.data}");
      throw e.response?.data['message'] ?? 'فشل في جلب الحجوزات';
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
  }
  static Future<bool> toggleFavorite(int apartmentId) async {
  final response = await _dio.post(
    'apartments/$apartmentId/favorite',
  );

  return response.data['is_favorite'] == true;
}

// 📥 get favorites
static Future<List<dynamic>> getFavorites() async {
  final response = await _dio.get('favorites');
  return response.data['data'];
}
  }