import 'dart:developer';

import 'package:biker_app/app/data/model/advertisement.dart';
import 'package:biker_app/app/data/model/shop.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerWidget extends StatelessWidget {
  final Advertisement ad;
  final Shop? shop;
  final Function()? onTap;
  const SellerWidget({super.key, required this.ad, this.onTap, this.shop});

  @override
  Widget build(BuildContext context) {
    log('${shop?.toJson()}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text(
          'Vendeur',
          style: AppTextStyles.base.s16.w700.blackColor,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.transparent,
              borderRadius: kRadius16,
              border: Border.all(width: 0.5, color: Color(0xFF7A7A7A)),
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
                    boxShadow: [
                      BoxShadow(
                        color: Color(
                          0x21000000,
                        ), // #00000021 = black with ~13% opacity
                        offset: Offset(0, 1),
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ],
                    image:
                        EndPoints.mediaUrl(shop?.logo) != null
                            ? DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                EndPoints.mediaUrl(shop?.logo)!,
                              ),
                            )
                            : null,
                  ),
                  child:
                      EndPoints.mediaUrl(shop?.logo) != null
                          ? SizedBox.shrink()
                          : Center(
                            child: Image.asset(
                              ImageConstants.motorcyclist,
                              height: 32,
                              color: AppColors.white,
                            ),
                          ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      shop?.nomEntreprise ?? ad.nomvendeur,
                      style: AppTextStyles.base.s12.w700.blackColor,
                    ),
                    Text(
                      ad.role == 'boutique'
                          ? 'Visitez la Boutique'
                          : 'Vendeur Particulier',
                      style: AppTextStyles.base.s11.w400.copyWith(
                        color:
                            ad.role == 'boutique'
                                ? Colors.blue
                                : Color(0xFF646982),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ).paddingSymmetric(horizontal: 24),
        ),
      ],
    ).paddingAll(16);
  }
}
