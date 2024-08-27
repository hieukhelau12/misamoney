import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:misamoneykeeper_flutter/main.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

class Globs {
  // Các key lưu trữ bộ nhớ cục bộ
  static const userPayload = "user_payload";
  static const userLogin = "user_login";

  // Lưu trữ dữ liệu bất kỳ (dynamic) vào bộ nhớ cục bộ với khóa (key) đã cho.
  static void udSet(dynamic data, String key) {
    var jsonStr = json.encode(data);
    prefs?.setString(key, jsonStr);
  }

  // lưu chữ chuỗi
  static void udStringSet(String data, String key) {
    prefs?.setString(key, data);
  }

  // lưu chữ boolean
  static void udBoolSet(bool data, String key) {
    prefs?.setBool(key, data);
  }

  // lưu chữ số nguyên
  static void udIntSet(int data, String key) {
    prefs?.setInt(key, data);
  }

  // lưu số thực
  static void udDoubleSet(double data, String key) {
    prefs?.setDouble(key, data);
  }

  // Truy xuất dữ liệu đã lưu theo khóa (key) và giải mã từ JSON thành kiểu dữ liệu ban đầu.
  static dynamic udValue(String key) {
    return json.decode(prefs?.get(key) as String? ?? "{}");
  }

  static String udValueString(String key) {
    return prefs?.get(key) as String? ?? "";
  }

  static bool udValueBool(String key) {
    return prefs?.get(key) as bool? ?? false;
  }

  static bool udValueTrueBool(String key) {
    return prefs?.get(key) as bool? ?? true;
  }

  static int udValueInt(String key) {
    return prefs?.get(key) as int? ?? 0;
  }

  static double udValueDouble(String key) {
    return prefs?.get(key) as double? ?? 0.0;
  }

  // Xóa dữ liệu đã lưu theo khóa (key) khỏi bộ nhớ cục bộ.
  static void udRemove(String key) {
    prefs?.remove(key);
  }

  // Lấy múi giờ hiện tại của thiết bị
  static Future<String> timeZone() async {
    try {
      return await FlutterTimezone.getLocalTimezone();
    } on PlatformException {
      return "";
    }
  }
}

// Các biến chứa api
class SVKey {
  static const mainUrl = "http://117.1.28.99";
  static const baseUrl = '$mainUrl/api/misamoneykeeper/';
  static const nodeUrl = mainUrl;

  static const svLogin = '${baseUrl}login';
  static const svSignUp = '${baseUrl}register';
  static const svLogout = '${baseUrl}logout';
  static const svRefresh = '${baseUrl}refreshaccesstoken';
  static const svReportAccount = '${baseUrl}account';
  static const svHomeStatus = '${baseUrl}history/home';
  static const svRecnetNoteHome = '${baseUrl}recnetnote/home';
  static const svRecnetNote = '${baseUrl}recnetnote';
  static const svCategory = '${baseUrl}category';
  static const svCategoryCollect = '${baseUrl}category/collect';
  static const svAddAccount = '${baseUrl}account/add';
  static const svUpdateAccount = '${baseUrl}account/update';
  static const svDeleteAccount = '${baseUrl}account/delete';
  static const svAddPlay = '${baseUrl}add/pay';
  static const svUpdatePlay = '${baseUrl}update/pay';
  static const svDeletePlay = '${baseUrl}delete/pay';
  static const svStatus = '${baseUrl}history';
  static const svSpending = '${baseUrl}spending';
  static const svCollect = '${baseUrl}collected';
  static const svCollectSpending = '${baseUrl}spendingcollected';
  static const svNotification = '${baseUrl}notification';
  static const svChangePass = '${baseUrl}newpassword';
  static const svUserProfile = '${baseUrl}profile';
  static const svUpdateUserProfile = '${baseUrl}profile/update';
}

//Các biến chứa key mà server trả về
class KKey {
  static const payload = "payload";
  static const status = "status";
  static const message = "message";
  static const messageError = "error_message";
  static const authToken = "auth_token";
  static const name = "name";
  static const email = "email";
  static const mobile = "mobile";
  static const address = "address";
  static const userId = "user_id";
  static const resetCode = "reset_code";
}
