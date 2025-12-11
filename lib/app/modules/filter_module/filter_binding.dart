/* import 'package:biker_app/app/data/provider/brand_provider.dart';
import 'package:get/get.dart';

import '../../../app/data/provider/filter_provider.dart';
import '../../../app/modules/filter_module/filter_controller.dart';

class FilterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterController>(
      () => FilterController(
        provider: FilterProvider(),
        brandProvider: BrandProvider(),
      ),
    );
  }
}
 */