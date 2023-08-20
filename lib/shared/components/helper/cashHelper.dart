import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static late SharedPreferences cache;

  static init() async {
    cache = await SharedPreferences.getInstance();
  }

  static Future<bool> putcache(
      {required String key, required dynamic value}) async {
    if (value is bool) {
      return await cache.setBool(key, value);
    } else if (value is String) {
      return cache.setString(key, value);
    } else if (value is int) {
      return await cache.setInt(key, value);
    }
    return await cache.setDouble(key, value);
  }

  static dynamic getData({required String key}) {
    return cache.get(key);
  }

  static Future<bool> removdata({required key}) async {
    return await cache.remove(key);
  }
}
