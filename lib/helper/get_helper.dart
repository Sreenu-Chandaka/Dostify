import 'package:get_storage/get_storage.dart';

class GetHelper {
  static GetHelper? _instance;
  static GetStorage _box=GetStorage();

  GetHelper._internal();

  /// Singleton instance of GetHelper.
  static Future<GetHelper> getInstance() async {
    if (_instance == null) {
      _instance = GetHelper._internal();
      await _initializeStorage();
    }
    return _instance!;
  }

  /// Initialize GetStorage.
  static Future<void> _initializeStorage() async {
    await GetStorage.init();
    _box = GetStorage();
  }

  /// Sets the current user ID.
 static void setCurrentUserId(String userId) {
    _box.write('user_id', userId);
  }

  /// Gets the current user ID.
 static String getCurrentUserId() {
    return _box.read('user_id');
  }
}
