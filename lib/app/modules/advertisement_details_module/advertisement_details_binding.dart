import 'package:biker_app/app/data/provider/premium_ads_provider.dart';
import 'package:get/get.dart';

import '../../data/provider/advertisement_provider.dart';
import '../../../app/modules/advertisement_details_module/advertisement_details_controller.dart';

class AdvertisementDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdvertisementDetailsController>(
      () => AdvertisementDetailsController(
        provider: AdvertisementProvider(),
        premiumAdsProvider: PremiumAdsProvider(),
      ),
    );
  }
}
