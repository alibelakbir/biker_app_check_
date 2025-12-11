import 'package:biker_app/app/modules/profile_module/widgets/version_widget.dart';

import '../../data/api/api.checker.dart';
import '../dashboard_module/dashboard_controller.dart';
import 'models/menu.dart';
import 'widgets/header_widget.dart';
import '../../routes/app_pages.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_theme.dart';
import '../../utils/image_constants.dart';
import '../../utils/local_data.dart';
import '../../utils/svg_image.dart';
import '../../utils/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../app/modules/profile_module/profile_controller.dart';
import 'widgets/menu_item.dart';

class ProfilePage extends GetWidget<ProfileController> {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Menu',
        titleStyle: AppTextStyles.base.s32.w700.blackColor,
        backgroundColor: AppColors.white,
        centerTitle: false,
        systemUiOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (LocalData.accessToken == null) {
                final result = await Get.toNamed(AppRoutes.auth) as bool?;
                if (result != null && result) {
                  Get.toNamed(AppRoutes.notification);
                }
              } else {
                Get.toNamed(AppRoutes.notification);
              }
            },
            icon: GetX<DashboardController>(
              builder: (dController) {
                return Badge(
                  isLabelVisible: dController.unseenNotifCount.value > 0,
                  backgroundColor: AppColors.red,
                  label: Text(
                    dController.unseenNotifCount.value.toString(),
                    style: AppTextStyles.base.s10.w500.whiteColor,
                  ),
                  child: SvgImage(ImageConstants.bell, color: AppColors.black),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              HeaderWidget(),
              Obx(
                () => Opacity(
                  opacity: controller.appUser != null ? 1 : 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mon compte',
                        style: AppTextStyles.base.s24.w500.blackColor,
                      ),
                      Column(
                        children:
                            myAccountList
                                .map(
                                  (e) => MenuItem(
                                    menu: e.copyWith(
                                      onTap:
                                          controller.appUser != null
                                              ? e.onTap
                                              : null,
                                    ),
                                  ),
                                )
                                .toList(),
                      ).paddingOnly(bottom: 16),
                    ],
                  ),
                ),
              ),
              Text('Autres', style: AppTextStyles.base.s24.w500.blackColor),
              Column(
                children: otherList.map((e) => MenuItem(menu: e)).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () =>
                        controller.appUser != null
                            ? GestureDetector(
                              onTap: () => ApiChecker.logout(),
                              child: Text(
                                'Déconnexion',
                                style: AppTextStyles.base.s16.w500.redColor
                                    .copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.red,
                                    ),
                              ),
                            )
                            : SizedBox.shrink(),
                  ),
                  VersionWidget(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
