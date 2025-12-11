import 'package:biker_app/app/data/model/advertisement.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class DetailWidget extends StatelessWidget {
  final Advertisement ad;
  const DetailWidget({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text(
          'Détail',
          style: AppTextStyles.base.s16.w700.blackColor,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        Row(
          children: [
            _detailItem('Marque', ad.marque),
            _detailItem('Modèle', ad.model),
          ],
        ),
        Row(
          children: [
            _detailItem('Année du modèle', ad.anneemodele),
            _detailItem('Année de circulation', ad.anneecirculation),
          ],
        ),
        Row(
          children: [
            _detailItem('Origine', ad.origine),
            _detailItem('État', ad.etat),
          ],
        ),
      ],
    ).paddingAll(16);
  }

  _detailItem(label, text) {
    return Expanded(
      child: Column(
        spacing: 3,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.base.s12.w500.blackColor),
          Text(
            text?.toString() ?? '--',
            style: AppTextStyles.base.s13.w400.copyWith(
              color: Color(0xFF7C7C7C),
            ),
          ),
        ],
      ),
    );
  }
}
