import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/provider/app_auth_provider.dart';
import '../../../app/modules/auth_module/auth_controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(
          provider: AppAuthProvider(),
          sharedPrefs: Get.find<SharedPreferences>(),
          firebaseAuth: Get.find<FirebaseAuth>(),
          googleSignIn: GoogleSignIn()),
    );
  }
}
