import '../../data/provider/app_auth_provider.dart';
import 'package:get/get.dart';

import '../../../app/modules/my_profile_module/my_profile_controller.dart';

class MyProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyProfileController>(
      () => MyProfileController(
        provider: AppAuthProvider(),
      ),
    );
  }
}
