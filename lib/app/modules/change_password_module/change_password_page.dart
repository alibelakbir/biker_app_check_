import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/back_oval_widget.dart';
import 'package:biker_app/app/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:biker_app/app/utils/widgets/app_button/app_button.dart';
import 'package:biker_app/app/utils/widgets/inputs/password_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'change_password_controller.dart';

class ChangePasswordPage extends GetWidget<ChangePasswordController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        backgroundColor: AppColors.white,
        brightness: Brightness.light,
        titleWidget: Row(
          children: [
            BackOvalWidget(backgroundColor: Color(0xFFECECEC)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Changer le mot de passe',
                style: AppTextStyles.base.s24.w600.blackColor,
              ),
              const SizedBox(height: 8),
              Text(
                'Veuillez saisir votre mot de passe actuel et votre nouveau mot de passe',
                style: AppTextStyles.base.s14.w500
                    .copyWith(color: Color(0xFF989898)),
              ),
              const SizedBox(height: 40),

              // Current Password
              Obx(() => PasswordInput(
                    title: 'Mot de passe actuel',
                    controller: controller.currentPasswordCtrl,
                    errorText: controller.currentPasswordErr.isNotEmpty
                        ? controller.currentPasswordErr.value
                        : null,
                    darkDecoration: false,
                  )),
              const SizedBox(height: 24),

              // New Password
              Obx(() => PasswordInput(
                    title: 'Nouveau mot de passe',
                    controller: controller.newPasswordCtrl,
                    errorText: controller.newPasswordErr.isNotEmpty
                        ? controller.newPasswordErr.value
                        : null,
                    darkDecoration: false,
                  )),
              const SizedBox(height: 8),
              Text(
                'Le mot de passe doit contenir au moins 8 caractères',
                style: AppTextStyles.base.s12.w400
                    .copyWith(color: Color(0xFF989898)),
              ),
              const SizedBox(height: 24),

              // Confirm Password
              Obx(() => PasswordInput(
                    title: 'Confirmer le nouveau mot de passe',
                    controller: controller.confirmPasswordCtrl,
                    errorText: controller.confirmPasswordErr.isNotEmpty
                        ? controller.confirmPasswordErr.value
                        : null,
                    darkDecoration: false,
                  )),
              const SizedBox(height: 40),

              // Submit Button
              Obx(() => AppButton(
                    margin: EdgeInsets.zero,
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.changePassword(),
                    text: controller.isLoading.value
                        ? 'Modification en cours...'
                        : 'Modifier le mot de passe',
                    isLoading: controller.isLoading.value,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
