import 'package:biker_app/app/modules/splash_module/splash_controller.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetWidget<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Material(
        color: AppColors.kPrimaryColor,
        child: Stack(
          children: [
            Center(
              child: Image(
                width: Get.width * 0.6,
                image: AssetImage('assets/img/logo_white.png'),
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'La plateforme N°1 au Maroc dédiée à la moto, \naux motards et à tout leur univers.',
                style: AppTextStyles.base.s14.w600.whiteColor,
                textAlign: TextAlign.center,
              ).paddingOnly(
                left: 16,
                right: 16,
                bottom: Get.context!.mediaQueryPadding.bottom,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
