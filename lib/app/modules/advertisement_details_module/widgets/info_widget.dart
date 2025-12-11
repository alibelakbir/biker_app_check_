import 'package:biker_app/app/data/model/advertisement.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class InfoWidget extends StatelessWidget {
  final Advertisement ad;
  const InfoWidget({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          spacing: 10,
          children: List.generate(3, (index) {
            switch (index) {
              case 1:
                return infoItem(ImageConstants.count, 'Kilométrage',
                    '${ad.kilometrage} km', index);
              case 2:
                return infoItem(
                    ImageConstants.datee, 'Circulation', ad.anneemodele, index);

              default:
                return infoItem(ImageConstants.ccc, 'Cylindrée',
                    '${ad.cylindre} cm3', index);
              //return infoItem(ImageConstants.essence, ad.motorisation, index);
            }
          }),
        ),
      ],
    ).paddingAll(16);
  }

  infoItem(image, label, value, index) => Expanded(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFF6F6F6),
            borderRadius: kRadius10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                image,
                height: 29,
              ),
              SizedBox(height: 16),
              Text(
                label,
                style: AppTextStyles.base.s12.w800.blackColor,
              ),
              SizedBox(height: 4),
              Text(
                value?.toString() ?? '--',
                style: AppTextStyles.base.s12.w400.blackColor,
              )
            ],
          ),
        ),
      );
}
