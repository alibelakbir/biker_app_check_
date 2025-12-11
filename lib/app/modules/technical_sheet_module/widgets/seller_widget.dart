import 'package:biker_app/app/data/model/brand.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerWidget extends StatelessWidget {
  final Brand brand;
  final Function()? onTap;
  const SellerWidget({super.key, required this.brand, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text(
          'Vendeur',
          style: AppTextStyles.base.s16.w600.blackColor,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: kRadius25,
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(150, 150, 154, 0.37),
                    offset: Offset(3, 3),
                    blurRadius: 11.8,
                    spreadRadius: 0)
              ],
            ),
            child: Row(
              spacing: 8,
              children: [
                Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(width: 4, color: AppColors.white),
                        boxShadow: [
                          BoxShadow(
                            color: Color(
                                0x21000000), // #00000021 = black with ~13% opacity
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0,
                          )
                        ]),
                    child: CachedImage(imageUrl: brand.logo)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      brand.name,
                      style: AppTextStyles.base.s12.w700.blackColor,
                    ),
                    Text(
                      'Marque Partenaire',
                      style: AppTextStyles.base.s12.w700
                          .copyWith(color: Color(0xFF646982)),
                    )
                  ],
                )
              ],
            ),
          ).paddingSymmetric(horizontal: 24),
        )
      ],
    ).paddingAll(16);
  }
}
