import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:flutter/material.dart';

class AdviceWidget extends StatelessWidget {
  const AdviceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        spacing: 12,
        children: [
          Text(
            "1. Vérifiez soigneusement le produit avant de l'acheter",
            style: AppTextStyles.base.s13.w400.blackColor,
          ),
          Text(
            "2. Rencontrez-vous uniquement dans des lieux publics",
            style: AppTextStyles.base.s13.w400.blackColor,
          ),
          Text(
            "3. Ne transférez jamais de l'argent à l'avance",
            style: AppTextStyles.base.s13.w400.blackColor,
          ),
        ],
      ),
    );
  }
}
