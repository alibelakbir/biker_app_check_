import 'package:biker_app/app/modules/listing_moto_module/widgets/filter_tags.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/helpers.dart';
import 'package:biker_app/app/utils/widgets/premium_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../app/modules/listing_moto_module/listing_moto_controller.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_raduis.dart';
import '../../utils/image_constants.dart';
import '../../utils/svg_image.dart';
import '../../utils/widgets/app_bar/custom_app_bar.dart';
import '../../utils/widgets/no_data_screen.dart';
import 'widgets/eq_item.dart';
import 'widgets/moto_item.dart';
import 'widgets/tab_component.dart';

class ListingMotoPage extends GetWidget<ListingMotoController> {
  const ListingMotoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: CustomAppBar(
        backgroundColor: AppColors.white,
        systemUiOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        preferredSizeWidget: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /* BackOvalWidget(backgroundColor: Color(0xFFF2F2F2))
                  .paddingSymmetric(horizontal: 16), */
              BackButton(color: AppColors.black),
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.goFilter(autoSearch: true),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: kRadius8,
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFFE6E2EA),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        spacing: 6,
                        children: [
                          Icon(Icons.search, color: AppColors.neutral3),
                          Text(
                            'Recherche modèle, moto',
                            textAlign: TextAlign.left,
                            style: AppTextStyles.base.s13.w400.neutral3Color,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              GestureDetector(
                onTap: controller.goFilter,
                child: Container(
                  height: 44,
                  width: 44,
                  margin: EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor,
                    borderRadius: kRadius8,
                  ),
                  child: Center(
                    child: SvgImage(
                      ImageConstants.sliders,
                      color: AppColors.white,
                      height: 20,
                    ),
                  ),
                ),
              ),
            ],
          ).paddingOnly(bottom: 6),
        ),
      ),
      body: SmartRefresher(
        key: Key('smart-1'),
        controller: controller.motoRefreshCntr,
        enablePullDown: false,
        enablePullUp: true,
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoading,
        header: WaterDropHeader(),
        footer: ClassicFooter(),
        child: CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.white,
              floating: true,
              snap: true,
              elevation: 4,
              automaticallyImplyLeading: false,
              expandedHeight: 40,
              pinned: false,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(40),
                child: TabComponent(),
              ),
            ),
            FilterTags(),
            // _buildFilter(),
            _buildBody(),
          ],
        ),
      ),
    );
  }

  _buildBody() {
    return Obx(() {
      switch (controller.tabIndex.value) {
        case 0:
          return controller.isLoadingMoto.value
              ? SliverToBoxAdapter(
                child: SizedBox(
                  height: Get.height * 0.5,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ),
              )
              : controller.motoResponse.value == null ||
                  controller.motoResponse.value!.annonces.isEmpty
              ? SliverToBoxAdapter(
                child: NoDataScreen(height: Get.height * 0.5),
              )
              : SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (controller.isAdIndex(index)) {
                        int adIndex =
                            (index + 1) ~/ (controller.adInterval + 1) - 1;
                        if (adIndex < controller.premiumAds.length) {
                          return PremiumAdWidget.card(
                            ad: controller.premiumAds[adIndex],
                            premiumAdsProvider: controller.premiumAdsProvider,
                          );
                        }
                      }
                      int itemIndex = index - controller.adsBeforeIndex(index);

                      return MotoItem(
                        moto:
                            controller.motoResponse.value!.annonces[itemIndex],
                      );
                    },
                    childCount:
                        controller.motoResponse.value!.annonces.length +
                        controller.numberOfAdsToInsert(),
                  ),
                ),
              );
        default:
          return controller.isLoadingEq.value
              ? SliverToBoxAdapter(
                child: SizedBox(
                  height: Get.height * 0.5,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ),
              )
              : controller.eqResponse.value == null ||
                  controller.eqResponse.value!.annonces.isEmpty
              ? SliverToBoxAdapter(
                child: NoDataScreen(height: Get.height * 0.5),
              )
              : SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => EqItem(
                      eq: controller.eqResponse.value!.annonces[index],
                      category: Helpers.getCategoryByIndex(
                        controller.tabIndex.value,
                      ),
                    ),
                    childCount: controller.eqResponse.value!.annonces.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.8, // width/height ratio
                  ),
                ),
              );
      }
    });
  }
}
