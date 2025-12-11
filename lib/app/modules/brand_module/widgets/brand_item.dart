import '../../../data/model/brand.dart';
import '../../brand_details_module/brand_details_page.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_raduis.dart';
import '../../../utils/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandItem extends StatelessWidget {
  final Brand brand;
  const BrandItem({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.brandDetails,
          arguments: BrandDetailsPage(brand: brand)),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: kRadius16,
          boxShadow: [
            BoxShadow(
                color: Color(0x14000000),
                offset: Offset(0, 0),
                blurRadius: 24,
                spreadRadius: 0)
          ],
        ),
        child: Center(
          child: CachedImage(
            imageUrl: brand.logo,
            height: 56,
            width: 56,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
