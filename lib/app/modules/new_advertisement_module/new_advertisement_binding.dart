import 'package:biker_app/app/data/provider/brand_provider.dart';
import 'package:get/get.dart';

import '../../../app/data/provider/new_advertisement_provider.dart';
import '../../../app/modules/new_advertisement_module/new_advertisement_controller.dart';

class NewAdvertisementBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewAdvertisementController>(
      () => NewAdvertisementController(
        provider: NewAdvertisementProvider(),
        brandProvider: BrandProvider(),
      ),
    );
  }
}
