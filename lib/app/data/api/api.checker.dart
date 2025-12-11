import 'package:biker_app/app/modules/profile_module/profile_controller.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/local_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/instance_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/common.dart';
import 'api_error.dart';

class ApiChecker {
  ApiChecker._();
  static Future<void> checkApi(ApiErrors apiErrors,
      {isDarkMode = false}) async {
    if (apiErrors.runtimeType == UnauthorizedError) {
      Common.showError('Session expired. Please try again later!');
      // refreshSession();
    } else {
      //Common.showError(apiErrors.message);
    }
  }

  static Future<void> logout() async {
    final sharedPrefs = Get.find<SharedPreferences>();
    final pController = Get.find<ProfileController>();

    await sharedPrefs.remove(CACHED_TOKEN);
    await sharedPrefs.remove(CACHED_USER);
    LocalData.setAccessToken(null);
    pController.setAppUser(null);

    await Get.find<FirebaseAuth>().signOut();
    var googleSignIn = GoogleSignIn();
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut();
    }
    Common.showSuccess(title: "Déconnexion réussie");
  }
}
