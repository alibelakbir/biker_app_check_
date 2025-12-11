import 'dart:developer';

import 'package:biker_app/app/data/model/setting_model.dart';
import 'package:biker_app/app/data/provider/profile_provider.dart';
import 'package:biker_app/app/modules/profile_module/profile_controller.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/local_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final remoteConfig = FirebaseRemoteConfig.instance;

  try {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 5),
        minimumFetchInterval: const Duration(seconds: 0),
      ),
    );
    await remoteConfig.fetchAndActivate();
    var setting = remoteConfig.getString('setting');
    SettingModel rSetting = SettingModel.fromJson(setting);
    LocalData.setSetting(rSetting);
    EndPoints.baseUrl = rSetting.url;
    log('Fetched: ${rSetting.toJson()}');
  } on FirebaseException catch (exception) {
    LocalData.setSetting(SettingModel());
    log(exception.toString());
  }

  final sharedPreferences = await SharedPreferences.getInstance();

  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  /* final imagePicker = ImagePicker();
  final googleSignIn = GoogleSignIn(); */

  Get.put(sharedPreferences);
  Get.put(firebaseAuth);
  Get.put(firebaseFirestore);
  /*Get.put(imagePicker);
  Get.put(googleSignIn); */

  Get.put(ProfileController(provider: ProfileProvider()), permanent: true);
}

/* Future<String> getProfile() async {
  final authController = Get.find<AuthController>();
  final sharedPrefs = Get.find<SharedPreferences>();

  String? tokenStr = sharedPrefs.getString(CACHED_TOKEN);

  if (tokenStr != null) {
    log('tokenStr: $tokenStr');

    LocalData.setAccessToken(tokenStr);
    try {
      final user = await authController.provider.profile();
      authController.setAppUser(user);
      //Get.offNamed(AppRoutes.dashboard,);
      return AppRoutes.dashboard;
    } on ApiErrors catch (_) {
      return AppRoutes.login;
    }
  } else {
    return AppRoutes.login;
  }
} */
