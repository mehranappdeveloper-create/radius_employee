import 'package:get_storage/get_storage.dart';

class StorageService {
  static final GetStorage _box = GetStorage();

  // Keys
  static const String loginKey = "is_logged_in";
  static const String emailKey = "email";
  static const String passwordKey = "password";

  /// ========================
  /// Login Status
  /// ========================

  static void setLoggedIn(bool value) {
    _box.write(loginKey, value);
  }

  static bool isLoggedIn() {
    return _box.read(loginKey) ?? false;
  }

  /// ========================
  /// Email
  /// ========================

  static void saveEmail(String email) {
    _box.write(emailKey, email);
  }

  static String getEmail() {
    return _box.read(emailKey) ?? "";
  }

  /// ========================
  /// Password
  /// ========================

  static void savePassword(String pass) {
    _box.write(passwordKey, pass);
  }

  static String getPassword() {
    return _box.read(passwordKey) ?? "";
  }

  /// ========================
  /// Clear All (Logout)
  /// ========================

  static void clearAll() {
    _box.erase();
  }
}
