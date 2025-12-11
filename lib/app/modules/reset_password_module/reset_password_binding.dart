import 'package:get/get.dart';

import '../../../app/data/provider/reset_password_provider.dart';
import '../../../app/modules/reset_password_module/reset_password_controller.dart';

class ResetPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(
      () => ResetPasswordController(
        provider: ResetPasswordProvider(),
      ),
    );
  }
}
