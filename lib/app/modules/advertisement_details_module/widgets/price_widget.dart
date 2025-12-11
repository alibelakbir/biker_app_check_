import 'package:biker_app/app/data/model/advertisement.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/date_converter.dart';
import 'package:biker_app/app/utils/helpers.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:biker_app/app/utils/svg_image.dart';
import 'package:biker_app/app/utils/widgets/shop_tag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceWidget extends StatelessWidget {
  final Advertisement ad;
  const PriceWidget({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 16,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                ad.titre,
                style: AppTextStyles.base.s22.w700.blackColor,
                maxLines: 2,
              ),
            ),
            ad.role == 'boutique' ? ShopTag() : SizedBox.shrink(),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                ad.vendu == 1 ? 'Vendu' : Helpers.formatPrice(ad.prix),
                style: AppTextStyles.base.s20.w500.blackColor,
              ),
            ),
            Row(
              spacing: 8,
              children: [
                Row(
                  spacing: 4,
                  children: [
                    SvgImage(
                      ImageConstants.calendar,
                      color: Color(0xFF2A2A2A),
                      height: 21,
                    ),
                    Text(
                      DateConverter.isoStringToLocalDateOnly(ad.dateajout),
                      style: AppTextStyles.base.s11.w300.copyWith(
                        color: Color(0xFF2A2A2A),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 4,
                  children: [
                    SvgImage(
                      ImageConstants.pin,
                      color: Color(0xFF2A2A2A),
                      width: 18,
                    ),
                    Text(
                      ad.ville,
                      style: AppTextStyles.base.s11.w300.copyWith(
                        color: Color(0xFF2A2A2A),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ).paddingAll(16);
  }
}
