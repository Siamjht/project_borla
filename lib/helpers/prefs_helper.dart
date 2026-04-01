import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';



class PrefsHelper extends GetxController {
  static String token = "";
  // static String tempToken = "";
  static String status = "";
  static bool isLogIn = false;
  static bool adminVerified = false;
  static bool subscription = false;
  //static bool isNotifications = true;
  static String refreshToken = "";
  static String userId = "";
  static String myImage = "";
  static String myName = "";
  static String myEmail = "";
  static String myRole = "";
  static String accountStatus = "";
  static String about = "";
  static String phone = "";
  static String phoneCountryCode = "";
  static String gender = "";
  static String address = "";
  static String paypalEmail = "";
  static String latitude = "";
  static String longitude = "";
  static double rating = 0;
  static double points = 0;
  static List<String> interests = [];
  static List<String> photos = [];
  static bool isAccountApproved = false;
  static bool onlineStatus = false;

  ///<<<======================== Get All Data Form Shared Preference ==============>

  static Future<void> getAllPrefData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token") ?? "";
    status = preferences.getString("status") ?? "";
    refreshToken = preferences.getString("refreshToken") ?? "";
    userId = preferences.getString("userId") ?? "";
    myImage = preferences.getString("myImage") ?? "";
    myName = preferences.getString("myName") ?? "";
    myEmail = preferences.getString("myEmail") ?? "";
    myRole = preferences.getString("myRole") ?? "";
    isLogIn = preferences.getBool("isLogIn") ?? false;
    adminVerified = preferences.getBool("adminVerified") ?? false;
    subscription = preferences.getBool("subscription") ?? false;
    onlineStatus = preferences.getBool("onlineStatus") ?? false;
    about = preferences.getString("about") ?? "";
    phone = preferences.getString("phone") ?? "";


    if (kDebugMode) {
      print("UserId:  $userId");
      print("Token: $token");
    }
  }


  ///<<<======================== Remove All and Get All again Data Form Shared Preference ============>

  static Future<void> removeAllPrefData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    preferences.setString("token", "");
    preferences.setString("status", "");
    preferences.setString("refreshToken", "");
    preferences.setString("userId", "");
    preferences.setString("myImage", "");
    preferences.setString("myName", "");
    preferences.setString("myEmail", "");
    preferences.setBool("isLogIn", false);
    preferences.setBool("adminVerified", false);
    preferences.setBool("subscription", false);
    //preferences.setBool("isNotifications", true);
    //preferences.setString("mySubscription", "shopping");
    preferences.setStringList("interests", []);
    preferences.setStringList("photos", []);
    preferences.setString("phoneCountryCode", "");
    preferences.setString("address", "");
    preferences.setString("paypalEmail", "");

    getAllPrefData();
  }


  ///<<<======================== Get Data Form Shared Preference ==============>

  static Future<String> getString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? "";
  }

  static Future<bool?> getBool(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key) ?? false;
  }

  static Future<int> getInt(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key) ?? (-1);
  }

  static Future<double> getDouble(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getDouble(key) ?? (-1);
  }

  static Future<List<String>> getStringList(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(key) ?? [];
  }

  ///<<<=====================Save Data To Shared Preference=====================>

  static Future<void> setStringList(String key, List<String> value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(key, value);
  }

  static Future setString(String key, value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }

  static Future setBool(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(key, value);
  }

  static Future setInt(String key, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setInt(key, value);
  }

  static Future setDouble(String key, double value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setDouble(key, value);
  }

  ///<<<==========================Remove Value==================================>

  static Future remove(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }

  // Clear all data from SharedPreferences
  static Future<void> clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

}
