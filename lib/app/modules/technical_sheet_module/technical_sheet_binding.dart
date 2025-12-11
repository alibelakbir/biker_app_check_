import 'package:get/get.dart';

import '../../../app/data/provider/technical_sheet_provider.dart';
import '../../../app/modules/technical_sheet_module/technical_sheet_controller.dart';

class TechnicalSheetBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TechnicalSheetController>(
      () => TechnicalSheetController(
        provider: TechnicalSheetProvider(),
      ),
    );
  }
}
