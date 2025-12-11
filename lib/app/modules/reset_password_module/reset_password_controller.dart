import 'package:biker_app/app/utils/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/data/provider/reset_password_provider.dart';

class ResetPasswordController extends GetxController {
  final ResetPasswordProvider? provider;
  ResetPasswordController({this.provider});

  final FirebaseAuth _auth = Get.find<FirebaseAuth>();
  final RxBool isLoading = false.obs;

  PageController pageController = PageController();

  TextEditingController emailCtrl = TextEditingController();
  String get email => emailCtrl.text.trim();

  RxString emailErr = ''.obs;

  @override
  onInit() {
    super.onInit();
    emailCtrl.addListener(() {
      if (emailErr.isEmpty && GetUtils.isEmail(email)) {
        emailErr.value = '';
      }
    });
  }

  Future<void> resetPassword() async {
    if (!isEmailValid()) return;
    try {
      Common.showLoading();
      await _auth.sendPasswordResetEmail(email: email);
      Get.back(closeOverlays: true);
      Common.showSuccess(
          title:
              "Un e-mail de réinitialisation de mot de passe a été envoyé. Veuillez vérifier votre e-mail.");
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred';
      if (e.code == 'user-not-found') {
        message = 'No user found with this email';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email address';
      }
      Common.closeLoading();
      Common.showError(message);
    }
  }

  verify() {}

  isEmailValid() {
    if (!GetUtils.isEmail(email)) {
      emailErr.value = 'invalid_email'.tr;
      return false;
    }
    return true;
  }
}
