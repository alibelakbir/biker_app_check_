import 'dart:developer';

import 'package:biker_app/app/utils/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final FirebaseAuth _auth = Get.find<FirebaseAuth>();
  final RxBool isLoading = false.obs;

  TextEditingController currentPasswordCtrl = TextEditingController();
  TextEditingController newPasswordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();

  String get currentPassword => currentPasswordCtrl.text.trim();
  String get newPassword => newPasswordCtrl.text.trim();
  String get confirmPassword => confirmPasswordCtrl.text.trim();

  RxString currentPasswordErr = ''.obs;
  RxString newPasswordErr = ''.obs;
  RxString confirmPasswordErr = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _setupListeners();
  }

  void _setupListeners() {
    currentPasswordCtrl.addListener(() {
      if (currentPasswordErr.isNotEmpty && currentPassword.isNotEmpty) {
        currentPasswordErr.value = '';
      }
    });

    newPasswordCtrl.addListener(() {
      if (newPasswordErr.isNotEmpty && _isValidNewPassword()) {
        newPasswordErr.value = '';
      }
    });

    confirmPasswordCtrl.addListener(() {
      if (confirmPasswordErr.isNotEmpty && _isValidConfirmPassword()) {
        confirmPasswordErr.value = '';
      }
    });
  }

  bool _isValidNewPassword() {
    return newPassword.length >= 8;
  }

  bool _isValidConfirmPassword() {
    return confirmPassword.isNotEmpty && confirmPassword == newPassword;
  }

  bool validateForm() {
    bool isValid = true;

    if (currentPassword.isEmpty) {
      currentPasswordErr.value = 'Le mot de passe actuel est requis';
      isValid = false;
    }

    if (newPassword.isEmpty) {
      newPasswordErr.value = 'Le nouveau mot de passe est requis';
      isValid = false;
    } else if (!_isValidNewPassword()) {
      newPasswordErr.value =
          'Le mot de passe doit contenir au moins 8 caractères';
      isValid = false;
    }

    if (confirmPassword.isEmpty) {
      confirmPasswordErr.value = 'La confirmation du mot de passe est requise';
      isValid = false;
    } else if (!_isValidConfirmPassword()) {
      confirmPasswordErr.value =
          'Nouveau mot de passe et confirmation ne sont pas identiques';
      isValid = false;
    }

    return isValid;
  }

  Future<void> changePassword() async {
    if (!validateForm()) return;

    try {
      isLoading.value = true;

      final user = _auth.currentUser;
      if (user == null) {
        Common.showError('Aucun utilisateur connecté');
        return;
      }

      // Re-authenticate user with current password
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // Update password
      await user.updatePassword(newPassword);

      // Clear form
      currentPasswordCtrl.clear();
      newPasswordCtrl.clear();
      confirmPasswordCtrl.clear();

      Get.back();

      Common.showSuccess(title: 'Mot de passe modifié');
    } on FirebaseAuthException catch (e) {
      String message = 'Une erreur est survenue';
      log(e.code);
      switch (e.code) {
        case 'wrong-password':
        case 'invalid-credential':
          message = 'Mot de passe actuel erroné';
          currentPasswordErr.value = message;
          return;
        case 'weak-password':
          message = 'Le nouveau mot de passe est trop faible';
          newPasswordErr.value = message;
          return;
        case 'requires-recent-login':
          message = 'Veuillez vous reconnecter pour changer votre mot de passe';
          Common.showError(message);
          return;
        default:
          message = e.message ?? 'Une erreur est survenue';
          Common.showError(message);

          return;
      }
    } catch (e) {
      Common.showError('Une erreur inattendue est survenue');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    currentPasswordCtrl.dispose();
    newPasswordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.onClose();
  }
}
