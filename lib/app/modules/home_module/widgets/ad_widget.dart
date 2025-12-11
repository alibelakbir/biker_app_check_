import 'dart:developer';

import 'package:biker_app/app/data/model/advertisement.dart';
import 'package:biker_app/app/modules/advertisement_details_module/advertisement_details_controller.dart';
import 'package:biker_app/app/modules/advertisement_details_module/advertisement_details_page.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/helpers.dart';
import 'package:biker_app/app/utils/widgets/cached_image.dart';
import 'package:biker_app/app/utils/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdWidget extends StatelessWidget {
  final Advertisement advertisement;
  final bool? isSimilar;
  final bool isMoto;
  final String category;
  const AdWidget({
    super.key,
    required this.advertisement,
    this.isSimilar = true,
    required this.isMoto,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      ontap: () async {
        log('isSimilar $isSimilar');
        if (isSimilar != null && isSimilar!) {
          await Get.delete<AdvertisementDetailsController>(
            force: true,
          ); // force removes even if being used
          Get.back();
        }
        Get.toNamed(
          AppRoutes.advertisementDetails,
          arguments: AdvertisementDetailsPage(
            id: advertisement.id,
            ad: advertisement,
            isMoto: isMoto,
            category: category,
          ),
        );
      },
      decoration: kLightCardDecoration.copyWith(color: Color(0xFFF8F8F8)),
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.only(bottom: 12),
      width: 210,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Hero(
            tag: 'ad-${advertisement.id}',
            child: CachedImage(
              height: 152,
              imageUrl: EndPoints.mediaUrl(advertisement.medias.first),
              borderRadius: kTopRadius10,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Text(
                advertisement.titre,
                style: AppTextStyles.base.s12.w400.blackColor,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                advertisement.prix != null
                    ? Helpers.formatPrice(advertisement.prix!)
                    : 'Prix non spécifié',
                style: AppTextStyles.base.s14.w700.blackColor,
              ),
            ],
          ).paddingSymmetric(horizontal: 12),
        ],
      ),
    );
  }
}
