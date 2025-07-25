// import 'package:shared_preferences/shared_preferences.dart';
//
// class CacheHelper {
//   static SharedPreferences? sharedPreferences;
//
//   // static init() async {
//   //   sharedPreferences = await SharedPreferences.getInstance();
//   // }
//   static Future<bool> init() async {
//     try {
//       sharedPreferences = await SharedPreferences.getInstance();
//       return true;
//     } catch (e) {
//       print('❌ Failed to initialize SharedPreferences: $e');
//       return false;
//     }
//   }
//
//   static Future<bool> putBool({
//     required String key,
//     required bool value,
//   }) async {
//     return await sharedPreferences!.setBool(key, value);
//   }
//
//   static bool? getBool({required String key}) {
//     return sharedPreferences!.getBool(key);
//   }
//   static Future<bool> setData({
//     required String key,
//     required dynamic value,
//   }) async {
//     try {
//       if (sharedPreferences == null) {
//         final initialized = await init();
//         if (!initialized) return false;
//       }
//
//       if (value is String) {
//         return await sharedPreferences!.setString(key, value);
//       } else if (value is bool) {
//         return await sharedPreferences!.setBool(key, value);
//       } else if (value is int) {
//         return await sharedPreferences!.setInt(key, value);
//       } else if (value is double) {
//         return await sharedPreferences!.setDouble(key, value);
//       } else {
//         print("❌ Unsupported type: ${value.runtimeType}");
//         return false;
//       }
//     } catch (e) {
//       print('❌ Error in setData: $e');
//       return false;
//     }
//   }
//   // static Future<bool> setData({
//   //   required String key,
//   //   required dynamic value,
//   // }) async {
//   //   if (value is String) {
//   //     return await sharedPreferences!.setString(key, value);
//   //   } else if (value is bool) {
//   //     return await sharedPreferences!.setBool(key, value);
//   //   } else if (value is int) {
//   //     return await sharedPreferences!.setInt(key, value);
//   //   } else if (value is double) {
//   //     return await sharedPreferences!.setDouble(key, value);
//   //   } else {
//   //     print("❌ Unsupported type: ${value.runtimeType}");
//   //     return false;
//   //   }
//   // }
//
//   static dynamic getData({required String key}) {
//     return sharedPreferences?.get(key);
//   }
//
//   static Future<bool> removeData({required String key}) async {
//     return await sharedPreferences!.remove(key);
//   }
// }
