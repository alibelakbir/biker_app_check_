import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/data/provider/notification_provider.dart';
import '../../../app/modules/notification_module/notification_controller.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(
      () => NotificationController(
        provider: NotificationProvider(),
        sharedPrefs: Get.find<SharedPreferences>(),
      ),
    );
  }
}
