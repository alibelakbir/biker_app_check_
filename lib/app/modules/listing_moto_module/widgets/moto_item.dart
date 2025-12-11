import 'package:biker_app/app/modules/advertisement_details_module/advertisement_details_page.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:biker_app/app/utils/svg_image.dart';
import 'package:biker_app/app/utils/widgets/cached_image.dart';
import 'package:biker_app/app/utils/widgets/shop_tag.dart';
import 'package:get/route_manager.dart';

import '../../../data/model/advertisement.dart';
import '../../../routes/app_pages.dart';
import '../../../themes/app_raduis.dart';
import '../../../themes/app_text_theme.dart';
import '../../../utils/helpers.dart';
import 'package:flutter/material.dart';
import '../../../utils/widgets/card_widget.dart';
import 'package:get/utils.dart';
import '../../../utils/extensions.dart';

class MotoItem extends StatelessWidget {
  final Advertisement moto;
  const MotoItem({super.key, required this.moto});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: kRadius5,
        border: Border.all(width: 1, color: Color(0xFFE6E6E6)),
      ),
      margin: EdgeInsets.only(bottom: 16),
      ontap:
          () => Get.toNamed(
            AppRoutes.advertisementDetails,
            arguments: AdvertisementDetailsPage(
              id: moto.id,
              ad: moto,
              isMoto: true,
              category: 'moto',
            ),
          ),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 232,
                child: Stack(
                  children: [
                    CachedImage(
                      imageUrl: EndPoints.mediaUrl(moto.medias.first),
                      borderRadius: kRadius10,
                    ),
                    moto.role == 'particulier'
                        ? SizedBox.shrink()
                        : Positioned(right: 12, bottom: 12, child: ShopTag()),
                  ],
                ),
              ).paddingAll(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          moto.titre,
                          style: AppTextStyles.base.s16.w500.blackColor,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        moto.vendu == 0 && moto.prix != null
                            ? Helpers.formatPrice(moto.prix!)
                            : '',
                        style: AppTextStyles.base.s16.w700.blackColor,
                      ),
                    ],
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      SvgImage(
                        ImageConstants.pin,
                        color: Color(0xFF8A8A8A),
                        width: 18,
                      ),
                      Text(
                        moto.ville,
                        style: AppTextStyles.base.s11.w400.copyWith(
                          color: Color(0xFF8A8A8A),
                        ),
                      ),
                    ],
                  ),
                ],
              ).paddingSymmetric(vertical: 8, horizontal: 12),
            ],
          ),
          moto.vendu == 0
              ? SizedBox.shrink()
              : Container(
                constraints: BoxConstraints.expand(height: 328),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  borderRadius: kRadius10,
                ),
                child: Center(
                  child: Text(
                    'Vendu',
                    style: AppTextStyles.base.s32.w700.whiteColor,
                  ),
                ),
              ),
          Positioned(
            left: 20,
            top: 20,
            child: Row(
              spacing: 8,
              children: [
                moto.kilometrage == null
                    ? SizedBox.shrink()
                    : chipWidget(
                      ImageConstants.kilometre,
                      '${moto.kilometrage!.toCommaSeparated()} km',
                    ),
                moto.cylindre == null
                    ? SizedBox.shrink()
                    : chipWidget(
                      ImageConstants.cylindre,
                      '${moto.cylindre} cm3',
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  chipWidget(String img, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.95),
        borderRadius: kRadius8,
      ),
      child: Row(
        spacing: 4,
        children: [
          Image.asset(img, height: 17),
          Text(
            text,
            style: AppTextStyles.base.s10.w400.copyWith(
              color: AppColors.black.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
