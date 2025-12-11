import 'package:biker_app/app/data/model/shop.dart';
import 'package:biker_app/app/modules/shop_details_module/widgets/product_item.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/back_oval_widget.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/helpers.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:biker_app/app/utils/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../../../app/modules/shop_details_module/shop_details_controller.dart';

class ShopDetailsPage extends GetWidget<ShopDetailsController> {
  final Shop shop;
  const ShopDetailsPage({super.key, required this.shop});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Image.asset(
                ImageConstants.shopClipper,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 260,
              ),
              Positioned(
                top: kToolbarHeight,
                left: 16,
                child: BackOvalWidget(),
              ),
              Column(
                children: [
                  SizedBox(height: 260 - 102), // space for the curve
                  Obx(
                    () => CachedImage(
                      height: 102,
                      width: 102,
                      borderSize: 2,
                      borderColor: AppColors.white,
                      shape: BoxShape.circle,
                      imageUrl: EndPoints.mediaUrl(controller.shop?.logo),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(
                            0,
                            0,
                            0,
                            0.25,
                          ), // rgba(0, 0, 0, 0.25)
                          offset: Offset(0, 4), // (x: 0px, y: 4px)
                          blurRadius: 11.1, // 11.1px blur
                          spreadRadius: 0, // 0px spread
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => Text(
                      controller.shop?.nomEntreprise ?? '',
                      style: AppTextStyles.base.s18.w600.blackColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Obx(
                    () => Text(
                      controller.shop?.telephone ?? '',
                      style: AppTextStyles.base.s15.w500.copyWith(
                        color: Color(0xFF544C4C),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, color: Color(0xFF544C4C)),
                        Text(
                          controller.shop?.ville.toUpperCase() ?? '',
                          style: AppTextStyles.base.s13.w500.copyWith(
                            color: Color(0xFF544C4C),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Directly use inside yoru [TabBar]
                  Theme(
                    data: Theme.of(context).copyWith(
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                    ),
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
                      tabs: List.generate(mesAnnonceCategoryList.length, (
                        index,
                      ) {
                        return Obx(
                          () => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  controller.tabIndex.value == index
                                      ? AppColors.kPrimaryColor
                                      : Color(0xFFF3F4F6),
                              borderRadius: kRadius20,
                            ),
                            child: Text(
                              mesAnnonceCategoryList[index]['name']!,
                              style: AppTextStyles.base.s14.w500.copyWith(
                                color:
                                    controller.tabIndex.value == index
                                        ? AppColors.white
                                        : AppColors.black,
                              ),
                            ),
                          ),
                        );
                      }),
                      indicator: RectangularIndicator(
                        paintingStyle: PaintingStyle.fill,
                        color: AppColors.transparent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Obx(
                    () => GridView.builder(
                      padding: const EdgeInsets.all(16.0),
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: controller.productList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // 2 items per row
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 24,
                            childAspectRatio: 0.9, // width/height ratio
                          ),
                      itemBuilder:
                          (context, index) => ProductItem(
                            ad: controller.productList[index],
                            isMoto: controller.tabIndex.value == 0,
                            category: Helpers.getCategoryByIndex(
                              controller.tabIndex.value,
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
