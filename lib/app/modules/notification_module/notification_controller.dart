
import 'package:biker_app/app/data/api/api.checker.dart';
import 'package:biker_app/app/data/api/api_error.dart';
import 'package:biker_app/app/data/model/notification.dart';
import 'package:biker_app/app/modules/dashboard_module/dashboard_controller.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/data/provider/notification_provider.dart';

class NotificationController extends GetxController {
  final NotificationProvider provider;
  final SharedPreferences sharedPrefs;
  NotificationController({required this.provider, required this.sharedPrefs});

  final notificationList = <AppNotification>[].obs;

  @override
  void onInit() {
    getNotification();
    super.onInit();
  }

  getNotification() async {
    try {
      final result = await provider.getNotifications();
      notificationList.value = result;
      lastSeenNotification();
      Get.find<DashboardController>().resetUnseenNotificationCount();
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  lastSeenNotification() async {
    String formatted = '${DateTime.now().toIso8601String().split('.').first}Z';
    await sharedPrefs.setString(CACHED_LAST_SEEN_NOTIFICATION, formatted);
  }
}
