import 'package:biker_app/app/data/provider/premium_ads_provider.dart';
import 'package:get/get.dart';

import '../../../app/data/provider/listing_moto_provider.dart';
import '../../../app/modules/listing_moto_module/listing_moto_controller.dart';

class ListingMotoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListingMotoController>(
      () => ListingMotoController(
        provider: ListingMotoProvider(),
        premiumAdsProvider: PremiumAdsProvider(),
      ),
    );
  }
}
