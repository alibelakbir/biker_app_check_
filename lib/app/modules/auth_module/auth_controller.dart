
import 'package:biker_app/app/data/api/api.checker.dart';
import 'package:biker_app/app/data/api/api_error.dart';
import 'package:biker_app/app/data/model/app_user.dart';
import 'package:biker_app/app/modules/profile_module/profile_controller.dart';
import 'package:biker_app/app/services/notification_services.dart';
import 'package:biker_app/app/utils/common.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/helpers.dart';
import 'package:biker_app/app/utils/local_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/provider/app_auth_provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:biker_app/app/utils/analytics_mixin.dart';

class AuthController extends GetxController
    with GetSingleTickerProviderStateMixin, AnalyticsMixin {
  final AppAuthProvider provider;
  final SharedPreferences sharedPrefs;
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  AuthController({
    required this.provider,
    required this.sharedPrefs,
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  late TabController _tabController;
  TabController get tabController => _tabController;
  final tabIndex = 0.obs;

  final cityList = <String>[].obs;
  Rxn<String?> selectedCity = Rxn<String?>();

  TextEditingController fNameCtrl = TextEditingController();
  TextEditingController lNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  TextEditingController confirmPassCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();

  String get fName => fNameCtrl.text.trim();
  String get lName => lNameCtrl.text.trim();
  String get email => emailCtrl.text.trim();
  String get pass => passCtrl.text.trim();
  String get confirmPass => confirmPassCtrl.text.trim();

  String get phone => phoneCtrl.text.trim();

  RxString fNameErr = ''.obs;
  RxString lNameErr = ''.obs;
  RxString emailErr = ''.obs;
  RxString passErr = ''.obs;
  RxString confirmPassErr = ''.obs;
  RxString phoneErr = ''.obs;

  changeTabIndex(int val) {
    tabIndex.value = val;
  }

  onSelectCity(String val) => selectedCity.value = val;

  @override
  onInit() {
    var params = Get.arguments;

    _tabController = TabController(
      initialIndex: params != null ? params['index'] as int : 0,
      length: 2,
      vsync: this,
    );
    super.onInit();
    if (params != null) {
      changeTabIndex(params['index'] as int);
    }
    getCities();

    // Track auth page view
    trackPageView(
      pageName: 'Authentication',
      parameters: {'initial_tab': params != null ? params['index'] as int : 0},
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        changeTabIndex(_tabController.index);
      }
    });

    inputsListener();
  }

  getCities() async {
    try {
      cityList.value = await provider.getCities();
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  addUser(User user) async {
    try {
      await provider.addUser(buildUserData(user));
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  addUser2(String? firstName, String? lastName, email, uid) async {
    try {
      await provider.addUser(buildUserData2(firstName, lastName, email, uid));
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  emailExist({String? emailArg}) async {
    try {
      return await provider.emailExist(emailArg ?? email);
    } on ApiErrors catch (_) {
      //ApiChecker.checkApi(e);
      return false;
    }
  }

  phoneExist() async {
    try {
      final result = await provider.phoneExist(
        Helpers.normalizeMoroccanPhone(phone),
      );
      if (result) {
        Get.back();
        Common.showError('phone_already_used'.tr);
      }
      return result;
    } on ApiErrors catch (e) {
      Common.closeLoading();
      ApiChecker.checkApi(e);
      return false;
    }
  }

  updateFcmTokem() async {
    final fcm = await NotificationServices().getDeviceToken();
    if (fcm == null) return;
    try {
      await provider.updateFcmToken(fcm);
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  getUser(String token) async {
    try {
      final user = await provider.getUser(token: token);
      if (user.uid != null) {
        saveUserToFirebase(
          firstname: user.prenom,
          lastname: user.nom,
          uid: user.uid!,
        );
      }
      updateFcmTokem();
      storeToken(token);
      storeUser(user);
      Get.back(result: true);
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  storeToken(String token) async {
    await sharedPrefs.setString(CACHED_TOKEN, token);
    LocalData.setAccessToken(token);
  }

  storeUser(AppUser user) async {
    final pController = Get.find<ProfileController>();
    await sharedPrefs.setString(CACHED_USER, user.toJson());
    pController.setAppUser(user);
  }

  void signIn(BuildContext context) async {
    if (!signInValidation()) return;
    Common.showLoading();
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: pass);

      final idToken = await userCredential.user!.getIdToken();
      Get.back();
      if (idToken != null) {
        getUser(idToken);
      }
    } on FirebaseAuthException catch (e) {
      Common.closeLoading();
      Common.showError(e.message ?? 'sign_in_failed'.tr);
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return; // User cancelled the sign-in
      Common.showLoading();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );
      if (userCredential.user != null) {
        String? token = await userCredential.user!.getIdToken();
        Get.back();
        if (token != null) getUser(token);
      }
    } on FirebaseAuthException catch (e) {
      Common.closeLoading();
      Common.showError(e.message ?? 'sign_in_failed'.tr);
    }
  }

  Future<void> signUp(BuildContext context) async {
    if (!signUpValidation()) return;
    Common.showLoading();

    final isPhoneExist = await phoneExist();
    if (isPhoneExist) return;

    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: pass);
      final idToken = await userCredential.user?.getIdToken();

      if (idToken != null) {
        await addUser(userCredential.user!);
        Get.back();
        await getUser(idToken);
      }
    } on FirebaseAuthException catch (e) {
      Common.closeLoading();
      if (e.code == 'email-already-in-use') {
        Common.showError('email_already_used'.tr);
      } else {
        Common.showError('${'error'.tr}: ${e.message}');
      }
    }
  }

  Future<void> signInWithApple(BuildContext context) async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      Common.showLoading();
      final userCredential = await firebaseAuth.signInWithCredential(
        oauthCredential,
      );
      if (userCredential.user != null) {
        String? token = await userCredential.user!.getIdToken();
        if (!(await emailExist(emailArg: userCredential.user!.email))) {
          await addUser2(
            appleCredential.givenName,
            appleCredential.familyName,
            userCredential.user!.email,
            userCredential.user!.uid,
          );
        }

        Get.back();
        if (token != null) getUser(token);
      }
    } on FirebaseAuthException catch (e) {
      Common.closeLoading();
      Common.showError(e.message ?? 'sign_in_failed'.tr);
    } catch (e) {
      Common.closeLoading();
      Common.showError('sign_in_failed'.tr);
    }
  }

  signInValidation() {
    if (!GetUtils.isEmail(email)) {
      emailErr.value = 'invalid_email'.tr;
      return false;
    }
    if (GetUtils.isLengthLessThan(pass, 8)) {
      passErr.value = 'invalid_password'.tr;
      return false;
    }

    return true;
  }

  signUpValidation() {
    if (!GetUtils.isUsername(fName)) {
      fNameErr.value = 'Prénom invalide';
      return false;
    }
    if (!GetUtils.isUsername(lName)) {
      lNameErr.value = 'Nom invalide';
      return false;
    }

    if (!GetUtils.isPhoneNumber('+212$phone')) {
      phoneErr.value = 'Numéro de téléphone invalide';
      return false;
    }
    if (!GetUtils.hasMatch(confirmPass, pass)) {
      confirmPassErr.value = 'Confirmation du mot de passe invalide';
      return false;
    }
    return true;
  }

  buildUserData(User user) => {
    "nom": lName,
    "prenom": fName,
    "email": email,
    "role": 'particulier',
    "telephone": '+212$phone',
    "ville": selectedCity.value!,
    "uid": user.uid,
    "date_ajout": DateTime.now().toIso8601String(),
  };

  buildUserData2(String? firstName, String? lastName, email, uid) => {
    "nom": '$firstName',
    "prenom": '$firstName',
    "email": email,
    "role": 'particulier',
    "uid": uid,
    "telephone": null,
    "ville": null,
  };

  void inputsListener() {
    fNameCtrl.addListener(() {
      if (fNameErr.isNotEmpty && GetUtils.isUsername(fName)) {
        fNameErr.value = '';
      }
    });
    lNameCtrl.addListener(() {
      if (lNameErr.isNotEmpty && GetUtils.isUsername(lName)) {
        lNameErr.value = '';
      }
    });
    emailCtrl.addListener(() {
      if (GetUtils.isEmail(email)) {
        emailErr.value = '';
      }
    });
    phoneCtrl.addListener(() {
      if (phoneErr.isNotEmpty && GetUtils.isPhoneNumber('+212$phone')) {
        phoneErr.value = '';
      }
    });
    passCtrl.addListener(() {
      if (passErr.isNotEmpty && GetUtils.isLengthGreaterOrEqual(pass, 8)) {
        passErr.value = '';
      }
    });
    confirmPassCtrl.addListener(() {
      if (confirmPass.isNotEmpty && GetUtils.hasMatch(confirmPass, pass)) {
        confirmPassErr.value = '';
      }
    });
  }

  Future<void> saveUserToFirebase({
    required String firstname,
    required String lastname,
    required String uid,
  }) async {
    final userDoc = FirebaseFirestore.instance
        .collection(EndPoints.fUsers)
        .doc(uid);
    final fcmToken = await NotificationServices().getDeviceToken();
    try {
      await userDoc.set({
        'firstname': firstname,
        'lastname': lastname,
        'fcmToken': fcmToken,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print('User saved to Firebase');
    } catch (e) {
      print('Error saving user: $e');
    }
  }
}
