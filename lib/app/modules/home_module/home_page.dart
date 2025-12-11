import 'package:biker_app/app/modules/dashboard_module/dashboard_controller.dart';
import 'package:biker_app/app/modules/home_module/widgets/category_component.dart';
import 'package:biker_app/app/modules/home_module/widgets/component_widget.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:biker_app/app/utils/local_data.dart';
import 'package:biker_app/app/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:biker_app/app/utils/widgets/premium_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:biker_app/app/modules/home_module/home_controller.dart';

class HomePage extends GetWidget<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        titleWidget: Image.asset(ImageConstants.logoWhite, height: 36),
        systemUiOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.kPrimaryColor,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        preferredSizeWidget: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CategoryComponent(),
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.listingMoto),
            child: Container(
              height: 46,
              width: 46,
              margin: EdgeInsets.only(right: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.search, color: AppColors.white, size: 26),
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (LocalData.accessToken == null) {
                final result = await Get.toNamed(AppRoutes.auth) as bool?;
                if (result != null && result) {
                  Get.toNamed(AppRoutes.notification);
                }
              } else {
                Get.toNamed(AppRoutes.notification);
              }
            },
            child: Container(
              height: 46,
              width: 46,
              margin: EdgeInsets.only(right: 16),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: GetX<DashboardController>(
                builder:
                    (dController) => Badge(
                      isLabelVisible: dController.unseenNotifCount.value > 0,
                      backgroundColor: AppColors.red,
                      label: Text(
                        dController.unseenNotifCount.value.toString(),
                        style: AppTextStyles.base.s10.w500.whiteColor,
                      ),
                      child: SvgPicture.asset(
                        ImageConstants.bell,
                        height: 26,
                        colorFilter: ColorFilter.mode(
                          AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 30,
          children: [
            /*  Obx(() => controller.brandList.isEmpty
                  ? SizedBox.shrink()
                  : BrandComponent(brands: controller.brandList)), */
            Obx(
              () =>
                  controller.bannerAd.value == null
                      ? SizedBox.shrink()
                      : PremiumAdWidget(
                        ad: controller.bannerAd.value!,
                        premiumAdsProvider: controller.premiumAdsProvider,
                        detectVisibility: false,
                      ),
            ),
            Obx(
              () =>
                  controller.motoAcceuilList.isEmpty
                      ? SizedBox.shrink()
                      : ComponentWidget(
                        title: 'Motos',
                        ads: controller.motoAcceuilList,
                        listingTabIndex: 0,
                        category: 'moto',
                      ),
            ),
            Obx(
              () =>
                  controller.motardList.isEmpty
                      ? SizedBox.shrink()
                      : ComponentWidget(
                        title: 'Équipement Motard',
                        ads: controller.motardList,
                        listingTabIndex: 1,
                        category: 'equipement-motard',
                      ),
            ),
            Obx(
              () =>
                  controller.motoList.isEmpty
                      ? SizedBox.shrink()
                      : ComponentWidget(
                        title: 'Équipement Moto',
                        ads: controller.motoList,
                        listingTabIndex: 2,
                        category: 'equipement-moto',
                      ),
            ),
            Obx(
              () =>
                  controller.pieceList.isEmpty
                      ? SizedBox.shrink()
                      : ComponentWidget(
                        title: 'Pièce de Rechange',
                        ads: controller.pieceList,
                        listingTabIndex: 4,
                        category: 'piece-rechange',
                      ),
            ),
            Obx(
              () =>
                  controller.pneuList.isEmpty
                      ? SizedBox.shrink()
                      : ComponentWidget(
                        title: 'Pneu',
                        ads: controller.pneuList,
                        listingTabIndex: 3,
                        category: 'pneu',
                      ),
            ),
          ],
        ).paddingSymmetric(vertical: 16),
      ),
    );
  }
}
