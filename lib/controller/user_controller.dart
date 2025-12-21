import 'package:get/get.dart';

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
    required String token,
  }) {
    firstName.value = userData['firstName'] ?? '';
    lastName.value = userData['lastName'] ?? '';
    phone.value = userData['phone'] ?? '';
    avatar.value = userData['avatar'] ?? '';
    birthday.value = userData['birthday'] ?? '';
    this.token.value = token;
    isLoggedIn.value = true;
    
    saveUserToStorage();
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
    // dependencies:
    //   get_storage: ^2.1.1
    // import 'package:get_storage/get_storage.dart';
    
    // final storage = GetStorage();
    // storage.write('user_firstName', firstName.value);
    // storage.write('user_lastName', lastName.value);
    // storage.write('user_phone', phone.value);
    // storage.write('user_token', token.value);
    // storage.write('user_isLoggedIn', isLoggedIn.value);
  }

  void loadUserFromStorage() {
    // final storage = GetStorage();
    // firstName.value = storage.read('user_firstName') ?? '';
    // lastName.value = storage.read('user_lastName') ?? '';
    // phone.value = storage.read('user_phone') ?? '';
    // token.value = storage.read('user_token') ?? '';
    // isLoggedIn.value = storage.read('user_isLoggedIn') ?? false;
  }

  void clearStorage() {
    // final storage = GetStorage();
    // storage.erase();
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

  void printUserInfo() {
    print('=== User Info ===');
    print('Name: $fullName');
    print('Phone: ${phone.value}');
    print('Logged in: ${isLoggedIn.value}');
    print('Token: ${token.value.isNotEmpty ? "***" : "Empty"}');
    print('=================');
  }
}
