import 'dart:developer';
import 'dart:io';

import 'package:biker_app/app/data/api/api.checker.dart';
import 'package:biker_app/app/data/api/api_error.dart';
import 'package:biker_app/app/data/model/app_user.dart';
import 'package:biker_app/app/data/provider/chat_provider.dart';
import 'package:biker_app/app/modules/brand_module/brand_page.dart';
import 'package:biker_app/app/modules/chat_room_module/chat_room_controller.dart';
import 'package:biker_app/app/modules/chat_room_module/chat_room_page.dart';
import 'package:biker_app/app/modules/home_module/home_page.dart';
import 'package:biker_app/app/modules/profile_module/profile_controller.dart';
import 'package:biker_app/app/modules/profile_module/profile_page.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/services/notification_services.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/helpers.dart';
import 'package:biker_app/app/utils/local_data.dart';
import 'package:biker_app/app/utils/widgets/bottom_sheet_provider/bottom_sheet_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/data/provider/dashboard_provider.dart';
import 'package:biker_app/app/utils/analytics_mixin.dart';

import 'widgets/update_app.dart';

class DashboardController extends GetxController with AnalyticsMixin {
  final DashboardProvider provider;
  final SharedPreferences sharedPrefs;

  final ChatProvider chatProvider;

  DashboardController({
    required this.provider,
    required this.sharedPrefs,
    required this.chatProvider,
  });

  NotificationServices notificationServices = NotificationServices();

  final RxInt tabIndex = 0.obs;
  final RxInt unseenNotifCount = 0.obs;

  List<Widget> tabs = const <Widget>[
    HomePage(),
    BrandPage(),
    ChatRoomPage(),
    ProfilePage(),
  ];
  late final Stream<int> totalUnreadCountStream;
  User? currentUser;

  Future<void> changeTabIndex(int val) async {
    int previousIndex = tabIndex.value;
    tabIndex.value = val;
    switch (tabIndex.value) {
      case 1:
        break;
      case 2:
        if (LocalData.accessToken == null) {
          final result = await Get.toNamed(AppRoutes.auth) as bool?;
          if (result != null && result) {
            Get.find<ChatRoomController>().loadRooms();
          } else {
            tabIndex.value = previousIndex;
          }
        } else {
          Get.find<ChatRoomController>().loadRooms();
        }
        break;
      case 3:
        break;
      case 4:
        tabIndex.value = previousIndex;
        break;
      default:
    }
    /*  if (val == 2) {
      await Get.toNamed(AppRoutes.reels);
      tabIndex.value = previousIndex;
    } */
  }

  @override
  void onInit() {
    getUserData();
    if (LocalData.accessToken != null) {
      getUnseenNotification();
    }

    super.onInit();
    // Track dashboard page view
    trackPageView(pageName: 'Dashboard');

    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit();
    notificationServices.setupInteractMessage();
    notificationServices.isTokenRefresh();

    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        log('device token');
        log(value.toString());
      }
    });
  }

  @override
  onReady() {
    super.onReady();
    checkUpdate();
  }

  Future<void> checkUpdate() async {
    PackageInfo pInfo = await Helpers.getAppInfos();
    int appVersion = int.parse(pInfo.version.replaceAll('.', ''));
    int remoteVersion = int.parse(
      Platform.isAndroid
          ? LocalData.setting.androidVersion.replaceAll('.', '')
          : LocalData.setting.iosVersion.replaceAll('.', ''),
    );
    if (appVersion < remoteVersion) {
      BottomSheetProvider.showBottomSheet(
        centerTitle: true,
        title: 'Nouvelle Mise à jour disponible',
        maxHeight: Get.size.height * 0.7,
        content: UpdateApp(),
      );
    }
  }

  getUserData() {
    final sharedPrefs = Get.find<SharedPreferences>();
    final pController = Get.find<ProfileController>();

    String? userStr = sharedPrefs.getString(CACHED_USER);
    if (userStr != null) {
      pController.setAppUser(AppUser.fromJson(userStr));
    }
  }

  getUnseenNotification() async {
    final lastSeenDate = sharedPrefs.getString(CACHED_LAST_SEEN_NOTIFICATION);
    if (lastSeenDate == null) return;
    try {
      final result = await provider.getUnseenNotificationCount(lastSeenDate);
      unseenNotifCount.value = result;
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  resetUnseenNotificationCount() => unseenNotifCount.value = 0;
}
