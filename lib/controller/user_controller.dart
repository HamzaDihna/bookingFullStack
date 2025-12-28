import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
 
class UserController extends GetxController {
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString phone = ''.obs;
  RxString avatar = ''.obs;
  RxString identityImage = ''.obs;
  RxString password = ''.obs;
  RxString birthday = ''.obs;
  RxBool isLoggedIn = false.obs;
  RxString token = ''.obs; 
  void setUserSignUp({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
    String? avatar,
    String? identityImage,
    String? birthday, required String confirmPassword,
  }) {
    this.firstName.value = firstName;
    this.lastName.value = lastName;
    this.phone.value = phone;
    this.password.value = password;
    this.avatar.value = avatar ?? '';
    this.identityImage.value = identityImage ?? '';
    this.birthday.value = birthday ?? '';
    this.isLoggedIn.value = true;
    
    saveUserToStorage();
  }
  void setUserLogIn({
    required String phone,
    required String password,
    String? firstName,
    String? lastName,
    String? avatar,
    String? token, 
  }) {
    this.phone.value = phone;
    this.password.value = password;
    this.firstName.value = firstName ?? '';
    this.lastName.value = lastName ?? '';
    this.avatar.value = avatar ?? '';
    this.token.value = token ?? '';
    this.isLoggedIn.value = true;
    
    saveUserToStorage();
  }
  void loginFromApi({
    required Map<String, dynamic> userData,
    String? token, // جعلته اختياري لأن الـ JSON الذي أرسلته لا يحتوي على توكن حالياً
  }) {
    // 1. معالجة الاسم: الباك إند يرسل "name". سنأخذ أول جزء منه كـ FirstName والباقي كـ LastName
    String fullNameFromServer = userData['name'] ?? '';
    List<String> nameParts = fullNameFromServer.split(' ');
    
    firstName.value = nameParts.isNotEmpty ? nameParts[0] : '';
    lastName.value = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    // 2. مطابقة بقية الحقول مع الـ JSON (Keys من Laravel)
    phone.value = userData['phone']?.toString() ?? '';
    avatar.value = userData['profile_image'] ?? ''; // كان عندك اسمه avatar
    identityImage.value = userData['id_image'] ?? ''; 
    birthday.value = userData['birth_date'] ?? ''; // كان عندك اسمه birthday
    
    // 3. حفظ التوكن إذا كان موجوداً
    if (token != null) {
      this.token.value = token;
      isLoggedIn.value = true;
    }

    // 4. الحفظ في الذاكرة (GetStorage)
    saveUserToStorage();
    
    print("✅ تم تحديث بيانات المستخدم: ${fullName}");
  }
  void updateProfile({
  String? newFirstName,
  String? newLastName,
  String? newPhone,
  String? newAvatar,
  String? newIdentityImage,
  String? newPassword,
  String? newBirthday,
}) {
  if (newFirstName != null) firstName.value = newFirstName;
  if (newLastName != null) lastName.value = newLastName;
  if (newPhone != null) phone.value = newPhone;
  if (newAvatar != null) avatar.value = newAvatar;
  if (newIdentityImage != null) identityImage.value = newIdentityImage;
  if (newPassword != null) password.value = newPassword;
  if (newBirthday != null) birthday.value = newBirthday;

  saveUserToStorage();
}

  void clearUser() {
    firstName.value = '';
    lastName.value = '';
    phone.value = '';
    avatar.value = '';
    identityImage.value = '';
    password.value = '';
    birthday.value = '';
    token.value = '';
    isLoggedIn.value = false;
    
    clearStorage();
  }
String get fullName => '${firstName.value} ${lastName.value}'.trim();

 void saveUserToStorage() { 
    
    final storage = GetStorage();
    storage.write('user_firstName', firstName.value);
    storage.write('user_lastName', lastName.value);
    storage.write('user_phone', phone.value);
    storage.write('user_token', token.value);
    storage.write('user_isLoggedIn', isLoggedIn.value);
  }

  void loadUserFromStorage() {
    final storage = GetStorage();
    firstName.value = storage.read('user_firstName') ?? '';
    lastName.value = storage.read('user_lastName') ?? '';
    phone.value = storage.read('user_phone') ?? '';
    token.value = storage.read('user_token') ?? '';
    isLoggedIn.value = storage.read('user_isLoggedIn') ?? false;
  }

  void clearStorage() {
    final storage = GetStorage();
    storage.erase();
  }

  Map<String, String> get authHeaders {
    return {
      'Authorization': 'Bearer ${token.value}',
      'Content-Type': 'application/json',
    };
  }
  bool get isProfileComplete {
    return firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        phone.isNotEmpty &&
        avatar.isNotEmpty &&
        identityImage.isNotEmpty;
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName.value,
      'lastName': lastName.value,
      'fullName': fullName,
      'phone': phone.value,
      'avatar': avatar.value,
      'identityImage': identityImage.value,
      'birthday': birthday.value,
      'isLoggedIn': isLoggedIn.value,
      'isProfileComplete': isProfileComplete,
    };
  }
void checkLoginStatus() {
  loadUserFromStorage(); // تحميل البيانات من GetStorage
  
  if (isLoggedIn.value && token.value.isNotEmpty) {
    // هنا نقرر أين نذهب
    Get.offAllNamed('/home'); // إذا مسجل دخول اذهب للهوم
  } else {
    Get.offAllNamed('/login'); // إذا لا، اذهب لتسجيل الدخول
  }
}
  void printUserInfo() {
    print('=== User Info ===');
    print('Name: $fullName');
    print('Phone: ${phone.value}');
    print('Logged in: ${isLoggedIn.value}');
    print('Token: ${token.value.isNotEmpty ? "***" : "Empty"}');
    print('=================');
  }
}
