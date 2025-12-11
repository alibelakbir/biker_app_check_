import 'package:biker_app/app/data/provider/advertisement_provider.dart';
import 'package:get/get.dart';

import '../../../app/modules/my_advertisement_module/my_advertisement_controller.dart';

class MyAdvertisementBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyAdvertisementController>(
      () => MyAdvertisementController(
        provider: AdvertisementProvider(),
      ),
    );
  }
}
