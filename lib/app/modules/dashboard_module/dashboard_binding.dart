import 'package:biker_app/app/data/provider/brand_provider.dart';
import 'package:biker_app/app/data/provider/chat_provider.dart';
import 'package:biker_app/app/data/provider/home_provider.dart';
import 'package:biker_app/app/data/provider/premium_ads_provider.dart';
import 'package:biker_app/app/modules/brand_module/brand_controller.dart';
import 'package:biker_app/app/modules/chat_room_module/chat_room_controller.dart';
import 'package:biker_app/app/modules/home_module/home_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/data/provider/dashboard_provider.dart';
import '../../../app/modules/dashboard_module/dashboard_controller.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(
        provider: DashboardProvider(),
        sharedPrefs: Get.find<SharedPreferences>(),
        chatProvider: ChatProvider(),
      ),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(
        provider: HomeProvider(),
                premiumAdsProvider: PremiumAdsProvider()

      ),
    );
    Get.lazyPut<ChatRoomController>(
      () => ChatRoomController(
        provider: ChatProvider(),
      ),
    );
    Get.lazyPut<BrandController>(
      () => BrandController(
        provider: BrandProvider(),
      ),
    );
  }
}
