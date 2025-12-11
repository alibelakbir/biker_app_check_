import 'dart:io';

import 'package:biker_app/app/data/model/advertisement.dart';
import 'package:biker_app/app/modules/advertisement_details_module/report_controller.dart';
import 'package:biker_app/app/modules/advertisement_details_module/widgets/advice_widget.dart';
import 'package:biker_app/app/modules/advertisement_details_module/widgets/description_widget.dart';
import 'package:biker_app/app/modules/advertisement_details_module/widgets/detail_widget.dart';
import 'package:biker_app/app/modules/advertisement_details_module/widgets/eq_detail_widget.dart';
import 'package:biker_app/app/modules/advertisement_details_module/widgets/info_widget.dart';
import 'package:biker_app/app/modules/advertisement_details_module/widgets/price_widget.dart';
import 'package:biker_app/app/modules/advertisement_details_module/widgets/report_form.dart';
import 'package:biker_app/app/modules/advertisement_details_module/widgets/seller_widget.dart';
import 'package:biker_app/app/modules/home_module/widgets/component_widget.dart';
import 'package:biker_app/app/modules/web_view.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_decoration.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/common.dart';
import 'package:biker_app/app/utils/extensions.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:biker_app/app/utils/svg_image.dart';
import 'package:biker_app/app/utils/widgets/app_button/app_button.dart';
import 'package:biker_app/app/utils/widgets/bottom_sheet_provider/bottom_sheet_provider.dart';
import 'package:biker_app/app/utils/widgets/cached_image.dart';
import 'package:biker_app/app/utils/widgets/carousel_images.dart';
import 'package:biker_app/app/utils/widgets/premium_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../app/modules/advertisement_details_module/advertisement_details_controller.dart';

class AdvertisementDetailsPage
    extends GetWidget<AdvertisementDetailsController> {
  final int id;
  final Advertisement? ad;
  final bool? isMoto;
  final String category;
  const AdvertisementDetailsPage({
    super.key,
    required this.id,
    this.ad,
    this.isMoto,
    required this.category,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () =>
            controller.ad == null
                ? SizedBox.shrink()
                : Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Get.size.height * 0.4,
                            child: Stack(
                              children: [
                                Hero(
                                  tag: 'ad-${controller.ad!.id}',
                                  child: CarouselImages(
                                    gallery:
                                        controller.ad!.medias
                                            .withoutNullsOrEmpty(),
                                  ),
                                ),
                                Positioned(
                                  top: kToolbarHeight - 10,
                                  left: 16,
                                  right: 16,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 38,
                                        decoration: BoxDecoration(
                                          color: AppColors.black.withOpacity(
                                            0.6,
                                          ),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            AppDecoration.searchShadow,
                                          ],
                                        ),
                                        child: Center(
                                          child: const BackButton(
                                            color: AppColors.black,
                                            style: ButtonStyle(
                                              iconSize: WidgetStatePropertyAll(
                                                18,
                                              ),
                                              iconColor: WidgetStatePropertyAll(
                                                AppColors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => controller.shareAd(),
                                        child: Container(
                                          height: 38,
                                          width: 38,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: AppColors.black.withOpacity(
                                              0.6,
                                            ),
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              AppDecoration.searchShadow,
                                            ],
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              ImageConstants.partage,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(height: 8),
                          PriceWidget(ad: controller.ad!),
                          Divider(
                            color: Color(0xFFDDDDDD).withOpacity(0.3),
                            height: 5,
                            thickness: 5,
                          ),
                          controller.ad!.type == null
                              ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InfoWidget(ad: controller.ad!),
                                  Divider(
                                    color: Color(0xFFDDDDDD).withOpacity(0.3),
                                    height: 5,
                                    thickness: 5,
                                  ),
                                ],
                              )
                              : SizedBox.shrink(),

                          controller.ad!.type == null
                              ? DetailWidget(ad: controller.ad!)
                              : EqDetailWidget(ad: controller.ad!),
                          Divider(
                            color: Color(0xFFDDDDDD).withOpacity(0.3),
                            height: 5,
                            thickness: 5,
                          ),
                          DescriptionWidget(desc: controller.ad!.description),
                          Obx(
                            () =>
                                controller.bannerAd.value == null
                                    ? SizedBox.shrink()
                                    : PremiumAdWidget(
                                      ad: controller.bannerAd.value!,
                                      premiumAdsProvider:
                                          controller.premiumAdsProvider,
                                    ),
                          ),
                          Divider(
                            color: Color(0xFFDDDDDD).withOpacity(0.3),
                            height: 5,
                            thickness: 5,
                          ),

                          Obx(
                            () =>
                                controller.seller?.nomEntreprise != null &&
                                        controller
                                            .seller!
                                            .nomEntreprise!
                                            .isNotEmpty
                                    ? SellerWidget(
                                      ad: controller.ad!,
                                      shop: controller.seller,
                                      onTap: () => controller.onTapSeller(),
                                    )
                                    : SellerWidget(
                                      ad: controller.ad!,
                                      onTap: () => controller.onTapSeller(),
                                    ),
                          ),
                          SizedBox(height: 12),
                          Divider(
                            color: Color(0xFFDDDDDD).withOpacity(0.3),
                            height: 5,
                            thickness: 5,
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 12,
                            children: [
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    BottomSheetProvider.showBottomSheet(
                                      maxHeight: Get.height * 0.28,
                                      title: 'Conseils',
                                      padding: EdgeInsets.zero,
                                      content: AdviceWidget(),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.withOpacity(0.1),
                                      borderRadius: kRadius12,
                                    ),
                                    child: Row(
                                      spacing: 8,
                                      children: [
                                        Icon(
                                          Icons.warning_amber_outlined,
                                          color: Colors.orange,
                                        ),
                                        Text(
                                          'Conseils',
                                          style: AppTextStyles.base.s12.w600
                                              .copyWith(color: Colors.orange),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.put(
                                      ReportController(
                                        provider: controller.provider,
                                        adId: id,
                                        isMoto: isMoto ?? false,
                                      ),
                                    );
                                    BottomSheetProvider.showBottomSheet(
                                      maxHeight: Get.height * 0.75,
                                      title: 'Signaler l\'annonce',
                                      content: ReportForm(),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.redAccent.withOpacity(0.1),
                                      borderRadius: kRadius12,
                                    ),
                                    child: Row(
                                      spacing: 8,
                                      children: [
                                        Icon(
                                          Icons.info_outline,
                                          color: Colors.redAccent,
                                        ),
                                        Text(
                                          'Signaler cette Annonce',
                                          style: AppTextStyles.base.s12.w600
                                              .copyWith(
                                                color: Colors.redAccent,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ).paddingSymmetric(vertical: 16, horizontal: 16),
                          Obx(
                            () =>
                                controller.similarList.isEmpty
                                    ? SizedBox.shrink()
                                    : ComponentWidget(
                                      title: 'Annonces similaires',
                                      ads: controller.similarList,
                                      showMore: false,
                                      isSimilar: true,
                                      category: category,
                                    ).paddingOnly(top: 20),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Obx(
                        () =>
                            controller.iconAd.value == null
                                ? SizedBox.shrink()
                                : PremiumAdWidget.icon(
                                  ad: controller.iconAd.value!,
                                  premiumAdsProvider:
                                      controller.premiumAdsProvider,
                                ),
                      ),
                    ),
                  ],
                ),
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            top: 12,
            bottom: Platform.isAndroid ? 16 : 0,
          ),
          decoration: BoxDecoration(
            borderRadius: kTopRadius,
            border: Border(
              top: BorderSide(color: Color(0xFFE8E8E8), width: 1),
              left: BorderSide.none,
              right: BorderSide.none,
              bottom: BorderSide.none,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Expanded(
                child: AppButton(
                  height: 44,
                  backgroundColor: Colors.blue.withOpacity(0.1),
                  color: Colors.blue.withOpacity(0.1),
                  onPressed:
                      () =>
                          controller.ad?.vendu == 1
                              ? Common.showError('Moto Vendu')
                              : controller.onAddEvent('appel'),
                  prefixIcon: SvgImage(
                    ImageConstants.phone,
                    height: 22,
                    color: Colors.blue,
                  ),
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                ),
              ),
              Expanded(
                child: AppButton.outline(
                  height: 44,
                  onPressed:
                      () =>
                          controller.ad?.vendu == 1
                              ? Common.showError('Article Vendu')
                              : controller.onAddEvent('chat'),
                  prefixIcon: SvgImage(
                    ImageConstants.message,
                    height: 22,
                    color: AppColors.kPrimaryColor,
                  ),
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                ),
              ),
              Expanded(
                child: AppButton(
                  height: 44,
                  onPressed: () => controller.onAddEvent('whatsapp'),
                  color: Color(0xFF939393).withOpacity(0.1),
                  prefixIcon: Image.asset(
                    ImageConstants.wtsp,
                    height: 25,
                    color: Color.fromARGB(255, 121, 120, 120),
                  ),
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 16),
        ),
      ),
    );
  }
}
