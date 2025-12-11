import 'package:biker_app/app/data/model/advertisement.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:biker_app/app/utils/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class EqDetailWidget extends StatelessWidget {
  final Advertisement ad;
  const EqDetailWidget({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        infoItem(ImageConstants.boutique, 'Marque', ad.marque),
        infoItem(ImageConstants.verifier, 'État', ad.etat),
        infoItem(ImageConstants.taille, 'Taille', ad.dimensions)
      ],
    ).paddingAll(16);
  }

  infoItem(image, label, text) => Column(
        spacing: 6,
        children: [
          Container(
            height: 70,
            width: 77,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: kRadius10,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  offset: Offset(0, 5),
                  blurRadius: 30,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 4,
              children: [
                SvgImage(
                  image,
                  height: 25,
                ),
                Text(
                  label,
                  style: AppTextStyles.base.s8.w500
                      .copyWith(color: Color(0xFF343434)),
                )
              ],
            ),
          ),
          Text(
            text ?? '--',
            style: AppTextStyles.base.s13.w500.blackColor,
          )
        ],
      );
}
