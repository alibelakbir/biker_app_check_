import 'package:biker_app/app/modules/reset_password_module/reset_password_controller.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/widgets/app_button/app_button.dart';
import 'package:biker_app/app/utils/widgets/inputs/pin_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerificationTab extends GetWidget<ResetPasswordController> {
  const EmailVerificationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Vérifiez votre Email',
                style: AppTextStyles.base.s20.w600.blackColor),
            const SizedBox(height: 8),
            Text(
                "Nous avons envoyé un lien de réinitialisation à ${controller.email} entrez le code à 4 chiffres mentionné dans l'e-mail",
                style: AppTextStyles.base.s14.w500
                    .copyWith(color: Color(0xFF989898))),
            const SizedBox(height: 40),
            Obx(() => PinInput(
                  errorText: controller.emailErr.isNotEmpty
                      ? controller.emailErr.value
                      : null,
                  onCompleted: (code) {
                    // Handle the completed PIN code
                    print('PIN Code entered: $code');
                    // You can add your verification logic here
                  },
                )),
            const SizedBox(height: 24),
            AppButton(
              margin: EdgeInsets.zero,
              onPressed: controller.isEmailValid,
              text: 'Vérifier le code',
            ),
          ],
        ),
      ),
    );
  }
}
