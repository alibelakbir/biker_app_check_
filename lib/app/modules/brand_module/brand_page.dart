import 'package:biker_app/app/modules/brand_module/widgets/brand_item.dart';
import 'package:biker_app/app/modules/dashboard_module/dashboard_controller.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/local_data.dart';
import 'package:biker_app/app/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:biker_app/app/utils/widgets/no_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../app/modules/brand_module/brand_controller.dart';
import '../../utils/image_constants.dart';

class BrandPage extends GetWidget<BrandController> {
  const BrandPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppBar(
          centerTitle: false,
          titleWidget: Image.asset(ImageConstants.logoWhite, height: 36),
          systemUiOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColors.kPrimaryColor,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          preferredSizeWidget: PreferredSize(
            preferredSize: Size.fromHeight(16),
            child: SizedBox.shrink(),
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
        body: Obx(
          () =>
              controller.brandList.isEmpty
                  ? NoDataScreen(height: Get.height, text: 'Bientôt disponible')
                  : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Marques de Motos',
                            style: AppTextStyles.base.s14.w700.copyWith(
                              color: AppColors.black,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Trouvez la moto de vos rêves en explorant les caractéristiques et les fiches techniques détaillées pour chaque modèle.',
                            style: AppTextStyles.base.s12.w500.copyWith(
                              color: AppColors.black,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 16),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount:
                                controller
                                    .brandList
                                    .length, // example item count
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // 2 items per row
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 3 / 2, // width/height ratio
                                ),
                            itemBuilder:
                                (context, index) => BrandItem(
                                  brand: controller.brandList[index],
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
        ),
      ),
    );
  }
}
