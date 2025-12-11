import 'package:get/get.dart';

import '../../../app/data/provider/brand_provider.dart';
import '../../../app/modules/brand_module/brand_controller.dart';

class BrandBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BrandController>(
      () => BrandController(
        provider: BrandProvider(),
      ),
    );
  }
}
