import 'dart:io';

import 'package:biker_app/app/modules/auth_module/widgets/cgu_widget.dart';
import 'package:biker_app/app/routes/app_pages.dart';

import '../auth_controller.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_raduis.dart';
import '../../../themes/app_text_theme.dart';
import '../../../utils/image_constants.dart';
import '../../../utils/svg_image.dart';
import '../../../utils/widgets/app_button/app_button.dart';
import '../../../utils/widgets/inputs/email_input.dart';
import '../../../utils/widgets/inputs/password_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginTab extends GetWidget<AuthController> {
  const LoginTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        Obx(
          () => EmailInput(
            controller: controller.emailCtrl,
            errorText:
                controller.emailErr.isNotEmpty
                    ? controller.emailErr.value
                    : null,
          ),
        ),
        Obx(
          () => PasswordInput(
            controller: controller.passCtrl,
            errorText:
                controller.passErr.isNotEmpty ? controller.passErr.value : null,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox.shrink(),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.resetPassword),
              child: Text(
                'Mot de passe oublié ?',
                style: AppTextStyles.base.s12.w600.blueColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        AppButton(
          onPressed: () => controller.signIn(context),
          text: 'Se connecter',
          margin: EdgeInsets.zero,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Divider(
                color: Color(0xFFEDF1F3),
                thickness: 1,
                endIndent: 16,
              ),
            ),
            Text(
              'Ou connectez-vous avec',
              style: AppTextStyles.base.s12.w400.copyWith(
                color: Color(0xFF6C7278),
              ),
            ),
            Expanded(
              child: Divider(
                color: Color(0xFFEDF1F3),
                thickness: 1,
                indent: 16,
              ),
            ),
          ],
        ).paddingSymmetric(vertical: 16),
        Platform.isIOS
            ? GestureDetector(
              onTap: () => controller.signInWithApple(context),
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: kRadius10,
                  border: Border.all(width: 1, color: Color(0xFFEFF0F6)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -3),
                      blurRadius: 6,
                      color: Color.fromRGBO(244, 245, 250, 0.6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8,
                  children: [
                    Image.asset(ImageConstants.apple, height: 21),
                    Text(
                      'Continue with Apple',
                      style: AppTextStyles.base.s14.w600.blackColor,
                    ),
                  ],
                ),
              ),
            )
            : GestureDetector(
              onTap: () => controller.signInWithGoogle(context),
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: kRadius10,
                  border: Border.all(width: 1, color: Color(0xFFEFF0F6)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -3),
                      blurRadius: 6,
                      color: Color.fromRGBO(244, 245, 250, 0.6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8,
                  children: [
                    SvgImage(ImageConstants.google),
                    Text(
                      'Continue with Google',
                      style: AppTextStyles.base.s14.w600.blackColor,
                    ),
                  ],
                ),
              ),
            ),
            CguWidget(),
      ],
    );
  }
}
