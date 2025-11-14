import 'package:get_storage/get_storage.dart';

class AuthService {
  static final box = GetStorage();

  // Save token
  static void saveToken(String token) {
    box.write('token', token);
    box.write('isLoggedIn', true);
  }

  static bool isLoggedIn() {
    return box.read('isLoggedIn') ?? false;
  }

  // Get token
  static String? getToken() {
    return box.read('token');
  }

  // Logout
  static void logout() {
    box.remove('token');
    box.remove('isLoggedIn');
  }
}
