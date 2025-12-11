import 'package:biker_app/app/data/provider/app_auth_provider.dart';
import 'package:get/get.dart';


import 'splash_controller.dart';


class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(
        sharedPrefs: Get.find(),
        authProvider: AppAuthProvider(),
      ),
    );
  }
}
