import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_text_theme.dart';
import '../../utils/back_oval_widget.dart';
import '../../utils/widgets/app_bar/custom_app_bar.dart';
import '../../utils/widgets/app_button/app_button.dart';
import '../../utils/widgets/inputs/email_input.dart';
import 'reset_password_controller.dart';

class ResetPasswordPage extends GetWidget<ResetPasswordController> {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppBar(
          backgroundColor: AppColors.white,
          titleWidget: Row(
            children: [BackOvalWidget(backgroundColor: Color(0xFFECECEC))],
          ),
          brightness: Brightness.light,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mot de passe oublié',
                  style: AppTextStyles.base.s20.w600.blackColor,
                ),
                const SizedBox(height: 8),
                Text(
                  'Veuillez saisir votre email pour réinitialiser\nle mot de passe',
                  style: AppTextStyles.base.s14.w500.copyWith(
                    color: Color(0xFF989898),
                  ),
                ),
                const SizedBox(height: 40),
                Obx(
                  () => EmailInput(
                    controller: controller.emailCtrl,
                    hint: 'Entrez votre email',
                    errorText:
                        controller.emailErr.isNotEmpty
                            ? controller.emailErr.value
                            : null,
                  ),
                ),
                const SizedBox(height: 24),
                AppButton(
                  margin: EdgeInsets.zero,
                  onPressed: controller.resetPassword,
                  text: 'Réinitialiser le mot de passe',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
