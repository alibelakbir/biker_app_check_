import 'package:biker_app/app/data/model/setting_model.dart';

class LocalData {
  LocalData._();

  static String? email;
  static String? accessToken;
  static String? refreshToken;
  static int? expireIn;

  static void setEmail(String? newVal) {
    email = newVal;
  }

  static void setAccessToken(String? newVal) {
    accessToken = newVal;
  }

  static void setRefreshToken(String? newVal) {
    refreshToken = newVal;
  }

  static void setExpireIn(int? newVal) {
    expireIn = newVal;
  }

  static late SettingModel _setting;
  static SettingModel get setting => _setting;

  static void setSetting(SettingModel val) => _setting = val;
}
