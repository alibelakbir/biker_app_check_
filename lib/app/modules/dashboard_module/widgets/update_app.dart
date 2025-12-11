import 'dart:io';

import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/helpers.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:biker_app/app/utils/widgets/app_button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateApp extends StatelessWidget {
  const UpdateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 32,
            children: [
              Container(
                constraints: const BoxConstraints(
                  maxHeight: 120,
                  maxWidth: 120,
                ),
                alignment: Alignment.center,
                child: Image.asset(ImageConstants.rocket),
              ),

              Text(
                "Cette version apporte une interface plus moderne, une meilleure expérience utilisateur et des performances améliorées.\n\nDécouvrez les nouveautés et profitez d’une navigation encore plus fluide !",
                style: AppTextStyles.base.s12.w500.copyWith(
                  color: Color(0xFF646982),
                ),
                textAlign: TextAlign.center,
              ).paddingSymmetric(horizontal: 20),
            ],
          ),
        ),

        Expanded(
          child: Column(
            spacing: 16,
            children: [
              AppButton(
                onPressed: () {
                  Get.back();
                  Helpers.openUrl(
                    Platform.isAndroid
                        ? EndPoints.androidStoreUrl
                        : EndPoints.iosStoreUrl,
                  );
                },
                text: 'Mettre à jour Maintenant',
                style: AppTextStyles.base.w600.s15.whiteColor,
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Pas maintenant',
                  style: AppTextStyles.base.w500.s14.redColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
