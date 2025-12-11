
import 'package:biker_app/app/data/model/brand.dart';
import 'package:biker_app/app/modules/brand_details_module/widgets/brand_moto_item.dart';
import 'package:biker_app/app/modules/technical_sheet_module/technical_sheet_page.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/utils/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/modules/brand_details_module/brand_details_controller.dart';

class BrandDetailsPage extends GetWidget<BrandDetailsController> {
  final Brand brand;
  const BrandDetailsPage({super.key, required this.brand});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 246, 246, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: (Get.size.height * 0.18) + 64,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: Get.size.height * 0.18,
                    decoration: BoxDecoration(
                        borderRadius: kBottomRadius32,
                        color: AppColors.kPrimaryColor),
                  ),
                  Positioned(
                    top: kToolbarHeight,
                    left: 16,
                    right: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipOval(
                          child: Container(
                            color: AppColors.white,
                            child: const BackButton(
                              color: AppColors.white,
                              style: ButtonStyle(
                                  iconSize: WidgetStatePropertyAll(20),
                                  iconColor:
                                      WidgetStatePropertyAll(AppColors.black)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: (Get.size.height * 0.18) - 64,
                    child: ClipOval(
                      child: Container(
                        height: 100,
                        width: 100,
                        padding: EdgeInsets.all(10),
                        color: AppColors.white,
                        child: CachedImage(
                          imageUrl: brand.logo,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Obx(() => controller.motoList.isEmpty
                ? SizedBox.shrink()
                : ListView.separated(
                    padding: EdgeInsets.all(16),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: controller.motoList.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(height: 16),
                    itemBuilder: (BuildContext context, int index) {
                      return BrandMotoItem(
                        moto: controller.motoList[index],
                        onTapDetails: () => Get.toNamed(
                            AppRoutes.technicalSheet,
                            arguments: TechnicalSheetPage(
                                brand: brand,
                                moto: controller.motoList[index])),
                      );
                    },
                  )),
          ],
        ),
      ),
    );
  }
}
