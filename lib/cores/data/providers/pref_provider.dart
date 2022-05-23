import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PrefProvider {
  static const String IS_DONE_INTRO_KEY = 'isDoneOnboarding';
  static const String TOKEN_KEY = 'token';
  static const String USER_DATA_KEY = 'userData';

  static FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  static void resetAfterLogin() async {
    await secureStorage.deleteAll();
    await secureStorage.write(key: IS_DONE_INTRO_KEY, value: 'true');
  }
}