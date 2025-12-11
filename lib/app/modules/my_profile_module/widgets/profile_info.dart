import 'package:biker_app/app/modules/profile_module/profile_controller.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:biker_app/app/utils/widgets/app_button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          GetX<ProfileController>(
            builder: (controller) {
              return Container(
                height: 75,
                width: 75,
                alignment: Alignment.center,
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
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        controller.appUser?.logo != null
                            ? NetworkImage(controller.appUser!.logo!)
                            : AssetImage(
                              ImageConstants.motorcyclist,
                              //color: AppColors.black,
                            ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 6),
          GetX<ProfileController>(
            builder: (controller) {
              return Text(
                '${controller.appUser!.prenom.capitalizeFirst} ${controller.appUser!.nom.capitalizeFirst}',
                style: AppTextStyles.base.s18.w700.blackColor,
              );
            },
          ),
          GetX<ProfileController>(
            builder: (controller) {
              return Text(
                controller.appUser!.email,
                style: AppTextStyles.base.s14.w400.copyWith(
                  color: Color(0xFF717171),
                  height: 1.2,
                ),
              );
            },
          ),
          SizedBox(height: 16),
          AppButton.outline(
            height: 35,
            padding: EdgeInsets.zero,
            onPressed: () => Get.toNamed(AppRoutes.editProfile),
            text: 'Modifier profil',
            color: Color(0xFF58B4FF),
            style: AppTextStyles.base.w600.s12.whiteColor,
            borderRadius: kRadius8,
          ),
        ],
      ),
    );
  }
}
