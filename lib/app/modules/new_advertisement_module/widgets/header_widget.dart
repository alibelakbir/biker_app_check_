import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class HeaderWidget extends StatelessWidget {
  final int pageIndex;
  const HeaderWidget({super.key, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    switch (pageIndex) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Type d’annonce',
              style: AppTextStyles.base.s24.w700.whiteColor,
            ),
            SizedBox(height: 4),
            Text(
              'Sélectionnez « Moto », « Équipement » ou une autre catégorie pour commencer.',
              style: AppTextStyles.base.s14.w400.whiteColor,
            ),
            SizedBox(height: 16),
          ],
        ).paddingSymmetric(horizontal: 16);
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Détails de l’objet',
              style: AppTextStyles.base.s24.w700.whiteColor,
            ),
            SizedBox(height: 4),
            Text(
              'Renseignez les caractéristiques techniques et l’état de votre article.',
              style: AppTextStyles.base.s14.w400.whiteColor,
            ),
            SizedBox(height: 16),
          ],
        ).paddingSymmetric(horizontal: 16);
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Description & Prix",
              style: AppTextStyles.base.s24.w700.whiteColor,
            ),
            SizedBox(height: 4),
            Text(
              'Ajoutez un titre accrocheur, une brève description et votre tarif.',
              style: AppTextStyles.base.s14.w400.whiteColor,
            ),
            SizedBox(height: 16),
          ],
        ).paddingSymmetric(horizontal: 16);
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Photos", style: AppTextStyles.base.s24.w700.whiteColor),
            SizedBox(height: 4),
            Text(
              'Téléchargez des images claires et attractives pour mettre votre annonce en valeur.',
              style: AppTextStyles.base.s14.w400.whiteColor,
            ),
            SizedBox(height: 16),
          ],
        ).paddingSymmetric(horizontal: 16);
      case 4:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Coordonnées vendeur",
              style: AppTextStyles.base.s24.w700.whiteColor,
            ),
            SizedBox(height: 4),
            Text(
              'Vérifiez Votre nom, ville et numéro de téléphone; les acheteurs pourront vous contacter.',
              style: AppTextStyles.base.s14.w400.whiteColor,
            ),
            SizedBox(height: 16),
          ],
        ).paddingSymmetric(horizontal: 16);
      default:
        return SizedBox.shrink();
    }
  }
}
