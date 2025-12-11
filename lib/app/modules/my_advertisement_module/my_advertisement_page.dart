import 'package:biker_app/app/modules/my_advertisement_module/tabs/eq_moto_tab.dart';
import 'package:biker_app/app/modules/my_advertisement_module/tabs/eq_oil_tab.dart';
import 'package:biker_app/app/modules/my_advertisement_module/tabs/eq_piece_tab.dart';
import 'package:biker_app/app/modules/my_advertisement_module/tabs/eq_pneu_tab.dart';
import 'package:biker_app/app/modules/my_advertisement_module/tabs/motard_tab.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/back_oval_widget.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:biker_app/app/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../../../app/modules/my_advertisement_module/my_advertisement_controller.dart';
import 'tabs/moto_tab.dart';

class MyAdvertisementPage extends GetWidget<MyAdvertisementController> {
  const MyAdvertisementPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: AppColors.white,
        brightness: Brightness.light,
        titleWidget: Row(
          children: [
            BackOvalWidget(backgroundColor: Color(0xFFECECEC)),
          ],
        ),
        preferredSizeWidget: PreferredSize(
          preferredSize: const Size.fromHeight(104),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Text(
                'Mes annonces',
                style: AppTextStyles.base.s32.w600.blackColor,
              ).paddingSymmetric(horizontal: 16),
              Theme(
                data: Theme.of(context).copyWith(
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent),
                child: TabBar(
                  controller: controller.tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicatorSize: TabBarIndicatorSize.label,
                  dividerHeight: 0,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.symmetric(horizontal: 8),
                  automaticIndicatorColorAdjustment: false,
                  tabs: List.generate(mesAnnonceCategoryList.length, (index) {
                    return Obx(() => Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          decoration: BoxDecoration(
                              color: controller.tabIndex.value == index
                                  ? Color(0xFF2D3535)
                                  : AppColors.transparent,
                              borderRadius: kRadius8,
                              border: Border.all(
                                  width: 1,
                                  color: controller.tabIndex.value == index
                                      ? Color(0xFF2D3535)
                                      : Color(0xFFDFDEDE))),
                          child: Row(
                            spacing: 6,
                            children: [
                              Image.asset(
                                '${ImageConstants.imagePath}/${mesAnnonceCategoryList[index]['imageName']!}',
                                color: controller.tabIndex.value == index
                                    ? AppColors.white
                                    : Color(0xFF2D3535),
                                height: 18,
                              ),
                              Text(
                                mesAnnonceCategoryList[index]['name']!,
                                style: AppTextStyles.base.s12.w500.copyWith(
                                  color: controller.tabIndex.value == index
                                      ? AppColors.white
                                      : Color(0xFF2D3535),
                                ),
                              ),
                            ],
                          ),
                        ));
                  }),
                  indicator: RectangularIndicator(
                    paintingStyle: PaintingStyle.fill,
                    color: AppColors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() {
        switch (controller.tabIndex.value) {
          case 1:
            return MotardTab();
          case 2:
            return EqMotoTab();
          case 3:
            return EqPneuTab();
          case 4:
            return EqPieceTab();
          case 5:
            return EqOilTab();
          default:
            return MotoTab();
        }
      }),
    );
  }
}
