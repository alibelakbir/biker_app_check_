import 'package:biker_app/app/data/model/brand.dart';
import 'package:biker_app/app/modules/brand_details_module/brand_details_page.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';

class BrandComponent extends StatelessWidget {
  final List<Brand> brands;
  const BrandComponent({super.key, required this.brands});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // padding: EdgeInsets.only(top: 6, bottom: 12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color(0x14000000),
              offset: Offset(0, 0),
              blurRadius: 24,
              spreadRadius: 0)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Text(
            'Marques officielles',
            style: AppTextStyles.base.s15.w600.blackColor,
          ).paddingSymmetric(horizontal: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: List.generate(
                    brands.length,
                    (index) => GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.brandDetails,
                          arguments: BrandDetailsPage(brand: brands[index])),
                      child: Container(
                        height: 80,
                        width: 80,
                        margin: EdgeInsets.only(right: 32),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: kRadius16,
                        ),
                        child: Center(
                          child: CachedImage(
                            imageUrl: brands[index].logo,
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
