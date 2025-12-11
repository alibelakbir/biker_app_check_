import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:biker_app/app/utils/local_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../app/modules/dashboard_module/dashboard_controller.dart';

class DashboardPage extends GetWidget<DashboardController> {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*   appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 16),
        child: Container(
          padding: EdgeInsets.only(
              top: Get.context!.mediaQueryPadding.top, left: 16, right: 16),
          decoration: BoxDecoration(color: AppColors.kPrimaryColor),
          child: Column(
            spacing: 20,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageConstants.logoWhite,
                    height: 36,
                  ),
                  Container(
                    height: 46,
                    width: 46,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.2),
                      borderRadius: kRadius8,
                    ),
                    child: Badge(
                      backgroundColor: AppColors.red,
                      label: Text('2',
                          style: AppTextStyles.base.s10.w500.whiteColor),
                      child: SvgPicture.asset(
                        ImageConstants.bell,
                        height: 26,
                        colorFilter:
                            ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                      ),
                    ),
                  )
                ],
              ),
              /*  Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: AppTextSearchField(
                      hintText: 'Recherche',
                      onTapSubmitted: (p0) => null,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  Container(
                    height: 46,
                    width: 46,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.2),
                      borderRadius: kRadius8,
                    ),
                    child: SvgPicture.asset(
                      ImageConstants.sliders,
                      colorFilter:
                          ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                    ),
                  )
                ],
              ) */
            ],
          ),
        ),
      ), */
      body: Obx(() => controller.tabs[controller.tabIndex.value]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () async {
          if (LocalData.accessToken == null) {
            final result = await Get.toNamed(AppRoutes.auth) as bool?;
            if (result != null && result) {
              Get.toNamed(AppRoutes.newAdvertisement);
            }
          } else {
            Get.toNamed(AppRoutes.newAdvertisement);
          }
        },
        child: Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: AppColors.kPrimaryColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              ImageConstants.plus,
              colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
              height: 24,
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: StreamBuilder<int>(
          stream: controller.chatProvider.getTotalUnreadCountStream(
            userId: Get.find<FirebaseAuth>().currentUser?.uid,
          ),
          builder: (context, snapshot) {
            final unreadCount = snapshot.data ?? 0;
            return Obx(
              () => AnimatedBottomNavigationBar.builder(
                safeAreaValues: const SafeAreaValues(bottom: false),
                backgroundColor: AppColors.white,
                elevation: 65,
                blurEffect: false,
                shadow: BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.06), // rgba(0,0,0,0.06)
                  offset: Offset(0, -3), // x: 0, y: -3
                  blurRadius: 17.6, // blur of 17.6
                  spreadRadius: 0, // no spread
                ),
                itemCount: controller.tabs.length,
                activeIndex: controller.tabIndex.value,
                gapLocation: GapLocation.center,
                notchSmoothness: NotchSmoothness.sharpEdge,
                leftCornerRadius: 0,
                rightCornerRadius: 0,
                onTap: (index) => controller.changeTabIndex(index),
                tabBuilder: (int index, bool isActive) {
                  switch (index) {
                    case 1:
                      return menuItem(
                        ImageConstants.brand,
                        'Marques',
                        isActive,
                      );
                    case 2:
                      return menuItem(
                        ImageConstants.chat,
                        'Message',
                        isActive,
                        badge:
                            unreadCount > 0
                                ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Badge(
                                    backgroundColor: AppColors.kPrimaryColor,
                                    label: Text(
                                      '$unreadCount',
                                      style:
                                          AppTextStyles.base.s8.w600.whiteColor,
                                    ),
                                  ),
                                )
                                : null,
                      );
                    case 3:
                      return menuItem(ImageConstants.menu, 'Menu', isActive);
                    default:
                      return menuItem(
                        ImageConstants.house,
                        'Acceuil',
                        isActive,
                      );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget menuItem(
    String iconName,
    String title,
    bool isActive, {
    Widget? badge,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Image.asset(
              iconName,
              color: isActive ? AppColors.kPrimaryColor : Color(0xFFACA9A7),
              width: 27,
              height: 20,
            ),
            if (badge != null) badge,
          ],
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: AppTextStyles.base.w700.s10.copyWith(
            color: isActive ? AppColors.kPrimaryColor : Color(0xFFACA9A7),
          ),
        ),
      ],
    );
  }
}
