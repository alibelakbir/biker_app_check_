import 'package:biker_app/app/data/model/brand_moto.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  final BrandMoto ad;
  const InfoWidget({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(3, (index) {
            switch (index) {
              case 1:
                return infoItem(
                    ImageConstants.kilometre, '${ad.cylindree} Cm3');
              case 2:
                return infoItem(ImageConstants.cylindre,
                    '+${ad.vitessemaximum.replaceAll('Supérieure à ', '')}');

              default:
                return infoItem(ImageConstants.essence, 'Essence');
            }
          }),
        ),
      ],
    );
  }

  infoItem(image, label) => Container(
        width: 100,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: kRadius14,
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
          spacing: 16,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(239, 251, 250, 1)),
              child: Center(
                  child: Image.asset(
                image,
                height: 30,
              )),
            ),
            Text(
              label?.toString() ?? '--',
              style: AppTextStyles.base.s13.w400.blackColor,
            )
          ],
        ),
      );
}
