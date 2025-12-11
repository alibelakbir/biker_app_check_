import 'package:biker_app/app/modules/advertisement_details_module/advertisement_details_controller.dart';
import 'package:biker_app/app/modules/advertisement_details_module/advertisement_details_page.dart';

import '../../../data/model/advertisement.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_raduis.dart';
import '../../../themes/app_text_theme.dart';
import '../../../utils/constants.dart';
import '../../../utils/helpers.dart';
import '../../../utils/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductItem extends StatelessWidget {
  final Advertisement ad;
  final bool? isMoto;
  final String category;
  const ProductItem({super.key, required this.ad, this.isMoto, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Get.delete<AdvertisementDetailsController>(force: true);
        Get.toNamed(
          AppRoutes.advertisementDetails,
          arguments: AdvertisementDetailsPage(
            id: ad.id,
            ad: ad,
            isMoto: isMoto,
            category: category,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: kRadius20,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.13), // rgba(0, 0, 0, 0.13)
              offset: Offset(0, 6), // (x: 0px, y: 6px)
              blurRadius: 17, // 17px blur
              spreadRadius: 0, // 0px spread
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Expanded(
              flex: 2,
              child: CachedImage(
                // height: 160,
                imageUrl: EndPoints.mediaUrl(ad.medias.first),
                borderRadius: kTopRadius20,
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 4,
                children: [
                  Text(
                    ad.prix != null
                        ? Helpers.formatPrice(ad.prix!)
                        : 'Prix non spécifié',
                    style: AppTextStyles.base.s13.w700.blackColor,
                  ),
                  Text(
                    ad.titre,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.base.s12.w400.copyWith(
                      color: Color(0xFF3C2F2F),
                    ),
                  ),
                ],
              ).paddingOnly(left: 16, right: 16, bottom: 16),
            ),
          ],
        ),
      ),
    );
  }
}
