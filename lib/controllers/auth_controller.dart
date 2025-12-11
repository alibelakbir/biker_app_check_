import 'package:biker_app/app/utils/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = Get.find<FirebaseAuth>();
  final RxBool isLoading = false.obs;

  Future<void> resetPassword(String email) async {
    try {
      isLoading.value = true;
      await _auth.sendPasswordResetEmail(email: email);
      Get.back();
      Common.showSuccess(
        title:
            'E-mail de réinitialisation du mot de passe envoyé. Veuillez vérifier votre boîte mail.',
      );
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred';
      if (e.code == 'user-not-found') {
        message = 'No user found with this email';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email address';
      }
      Common.showError(message);
    } finally {
      isLoading.value = false;
    }
  }
}
