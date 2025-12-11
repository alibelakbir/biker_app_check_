import 'package:biker_app/app/data/model/brand_moto.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceNameWidget extends StatelessWidget {
  final BrandMoto moto;
  const PriceNameWidget({super.key, required this.moto});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        moto.prix == null
            ? SizedBox.shrink()
            : Text(
                Helpers.formatPrice(moto.prix!),
                style: AppTextStyles.base.s24.w700.kPrimaryColor,
              ),
        Text(
          '${moto.marque} ${moto.modele ?? ''} ${moto.anneemodele ?? ''}',
          style: AppTextStyles.base.s20.w600.blackColor,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    ).paddingSymmetric(horizontal: 16);
  }
}
