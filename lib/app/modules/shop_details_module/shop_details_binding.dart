import 'package:get/get.dart';

import '../../../app/data/provider/shop_details_provider.dart';
import '../../../app/modules/shop_details_module/shop_details_controller.dart';

class ShopDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopDetailsController>(
      () => ShopDetailsController(
        provider: ShopDetailsProvider(),
      ),
    );
  }
}
