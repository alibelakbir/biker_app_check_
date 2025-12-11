import 'package:biker_app/app/data/model/brand_moto.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/helpers.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:biker_app/app/utils/svg_image.dart';
import 'package:biker_app/app/utils/widgets/app_button/app_button.dart';
import 'package:biker_app/app/utils/widgets/cached_image.dart';
import 'package:biker_app/app/utils/widgets/card_widget.dart';
import 'package:flutter/material.dart';

class BrandMotoItem extends StatelessWidget {
  final BrandMoto moto;
  final Function()? onTapDetails;
  const BrandMotoItem({super.key, required this.moto, this.onTapDetails});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              moto.modele ?? '--',
              style: AppTextStyles.base.s16.w600.blackColor,
            ),
            Text(
              moto.marque,
              style: AppTextStyles.base.s14.w400
                  .copyWith(color: Color(0xFFB2B2B2)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Hero(
                  tag: 'moto-${moto.id}',
                  child: CachedImage(
                    height: 150,
                    width: 200,
                    imageUrl: EndPoints.brandMotoMediaUrl(moto.medias.first),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Row(
                      spacing: 6,
                      children: [
                        SvgImage(ImageConstants.gas),
                        Text('${moto.reservoir.toUpperCase()} / 100 Km',
                            style: AppTextStyles.base.s11.w400
                                .copyWith(color: Color(0xFF89C7C4))),
                      ],
                    ),
                    Row(
                      spacing: 6,
                      children: [
                        Image.asset(
                          ImageConstants.cc,
                          width: 14,
                        ),
                        Text('${moto.cylindree} cc',
                            style: AppTextStyles.base.s11.w400
                                .copyWith(color: Color(0xFF89C7C4))),
                      ],
                    ),
                    Row(
                      spacing: 6,
                      children: [
                        Image.asset(ImageConstants.calendarPrimary),
                        Text(moto.anneemodele?.toString() ?? '--',
                            style: AppTextStyles.base.s11.w400
                                .copyWith(color: Color(0xFF89C7C4))),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        moto.prix == null
                            ? 'Prix non spécifié'
                            : Helpers.formatPrice(moto.prix!),
                        style: AppTextStyles.base.s20.w700.blackColor),
                    moto.prixpromotion == null
                        ? SizedBox.shrink()
                        : Text(Helpers.formatPrice(moto.prixpromotion!),
                            style: AppTextStyles.base.s12.w500.copyWith(
                                color: Color(0xFF90A3BF),
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Color(0xFF90A3BF))),
                  ],
                ),
                AppButton(
                  width: 100,
                  height: 36,
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  onPressed: onTapDetails,
                  text: 'Voir details',
                  style: AppTextStyles.base.s12.w500.whiteColor,
                  borderRadius: kRadius4,
                )
              ],
            )
          ],
        ));
  }
}
