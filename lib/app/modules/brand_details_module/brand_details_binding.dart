import 'package:biker_app/app/data/provider/brand_provider.dart';
import 'package:get/get.dart';

import '../../../app/modules/brand_details_module/brand_details_controller.dart';

class BrandDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BrandDetailsController>(
      () => BrandDetailsController(
        provider: BrandProvider(),
      ),
    );
  }
}
