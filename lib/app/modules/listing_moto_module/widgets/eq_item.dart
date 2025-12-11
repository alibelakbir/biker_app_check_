import 'package:biker_app/app/data/model/advertisement.dart';
import 'package:biker_app/app/modules/advertisement_details_module/advertisement_details_page.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/helpers.dart';
import 'package:biker_app/app/utils/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EqItem extends StatelessWidget {
  final Advertisement eq;
  final String category;
  const EqItem({super.key, required this.eq, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Get.toNamed(
            AppRoutes.advertisementDetails,
            arguments: AdvertisementDetailsPage(
              id: eq.id,
              ad: eq,
              isMoto: false,
              category: category,
            ),
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Expanded(
            flex: 3,
            child: CachedImage(
              // height: 160,
              imageUrl: EndPoints.mediaUrl(eq.medias.first),
              borderRadius: kRadius16,
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              children: [
                Text(
                  eq.titre,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.base.s14.w400.copyWith(
                    color: Color(0xFFA8A8A8),
                  ),
                ),
                Text(
                  eq.prix != null
                      ? Helpers.formatPrice(eq.prix!)
                      : 'Prix non spécifié',
                  style: AppTextStyles.base.s15.w700.blackColor,
                ),
              ],
            ).paddingSymmetric(horizontal: 8),
          ),
        ],
      ),
    );
  }
}
