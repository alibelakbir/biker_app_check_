import 'package:biker_app/app/data/provider/premium_ads_provider.dart';
import 'package:get/get.dart';
import 'package:biker_app/app/data/provider/home_provider.dart';
import 'package:biker_app/app/modules/home_module/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        provider: HomeProvider(),
        premiumAdsProvider: PremiumAdsProvider()
      ),
    );
  }
}
