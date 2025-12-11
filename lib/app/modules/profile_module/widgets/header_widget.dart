import 'package:biker_app/app/modules/profile_module/profile_controller.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:biker_app/app/utils/widgets/app_button/app_button.dart';
import 'package:biker_app/app/utils/widgets/app_divider/app_divider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderWidget extends GetWidget<ProfileController> {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          controller.appUser != null
              ? Column(
                spacing: 20,
                children: [
                  Row(
                    spacing: 16,
                    children: [
                      Container(
                        height: 61,
                        width: 61,
                        decoration: BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.08),
                              offset: Offset(0, 1),
                              blurRadius: 4,
                              spreadRadius: 3,
                            ),
                          ],
                          image:
                              controller.appUser?.logo != null
                                  ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      controller.appUser!.logo!,
                                    ),
                                  )
                                  : null,
                        ),
                        child:
                            controller.appUser?.logo == null
                                ? Center(
                                  child: Image.asset(
                                    ImageConstants.motorcyclist,
                                    height: 45,
                                    color: AppColors.black,
                                  ),
                                )
                                : SizedBox.shrink(),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Salut ${controller.appUser!.prenom.capitalizeFirst}',
                            style: AppTextStyles.base.s18.w400.blackColor,
                          ),
                          Text(
                            controller.appUser!.email,
                            style: AppTextStyles.base.s14.w400.copyWith(
                              color: Color(0xFF717171),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  AppDivider(color: Color(0xFFEAEAEA), height: 1),
                ],
              ).paddingOnly(bottom: 16)
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  AppButton(
                    onPressed: () => Get.toNamed(AppRoutes.auth),
                    text: 'Se connecter',
                    margin: EdgeInsets.zero,
                  ),
                  RichText(
                    text: TextSpan(
                      style: AppTextStyles.base.s11.w300.copyWith(
                        color: Color(0xFF838383),
                      ),
                      children: [
                        TextSpan(text: "Vous n'avez pas de compte ? "),
                        TextSpan(
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap =
                                    () => Get.toNamed(
                                      AppRoutes.auth,
                                      arguments: {"index": 1},
                                    ),
                          text: "Inscrivez-vous",
                          style: AppTextStyles.base.s11.w600.blackColor
                              .copyWith(decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
