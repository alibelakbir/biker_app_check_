import 'dart:developer';

import 'package:biker_app/app/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../data/api/api.checker.dart';
import '../../data/api/api_error.dart';
import '../../data/provider/app_auth_provider.dart';
import '../../routes/app_pages.dart';
import '../../utils/constants.dart';
import '../../utils/local_data.dart';
import '../../utils/analytics_mixin.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin, AnalyticsMixin {
  final SharedPreferences sharedPrefs;
  final AppAuthProvider authProvider;

  late AnimationController animController;
  late Animation<double> sizeAnimation;

  SplashController({required this.sharedPrefs, required this.authProvider});

  @override
  void onReady() {
    super.onReady();
    // Track splash page view
    trackPageView(pageName: 'Splash');

    Future.delayed(const Duration(milliseconds: 1500), () {
      getCachedData();
    });
  }

  void getCachedData() {
    String? tokenStr = sharedPrefs.getString(CACHED_TOKEN);
    String? guestUIDStr = sharedPrefs.getString(CACHED_GUEST_UID);

    LocalData.setAccessToken(tokenStr);
    log('guest:$guestUIDStr');
    if (guestUIDStr == null) updateFcmTokem();
    Get.offNamed(AppRoutes.dashboard);
  }

  Future<void> getProfile() async {
    try {
      await authProvider.getUser();
      Get.offNamed(AppRoutes.dashboard);
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  updateFcmTokem() async {
    final fcm = await NotificationServices().getDeviceToken();
    log('guest fcm:$fcm');

    if (fcm == null) return;
    final uid = Uuid().v8();
    try {
      await authProvider.updateFcmToken(fcm, guestId: uid);
      sharedPrefs.setString(CACHED_GUEST_UID, uid);
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }
}
