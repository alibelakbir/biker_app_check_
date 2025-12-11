import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:biker_app/app/utils/widgets/app_button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class CongratulationsPage extends StatelessWidget {
  const CongratulationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: AppColors.white,
        titleWidget: SizedBox.shrink(),
        brightness: Brightness.light,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Félicitations !",
              style: AppTextStyles.base.s20.w600.blackColor,
            ),
            SizedBox(height: 64),
            Text(
              "Votre annonce a été soumise avec succès et elle est en phase de validation.\n\nElle sera publiée dans quelques instants.",
              style: AppTextStyles.base.s15.w400
                  .copyWith(color: Color(0xFF6A6A6A)),
              textAlign: TextAlign.center,
            ),
            Text(
              "Bonne chance pour la vente !",
              style: AppTextStyles.base.s15.w400.primaryColor,
            ),
            SizedBox(height: 64),
            AppButton(
              onPressed: () => Get.offNamed(AppRoutes.myAdvertisement),
              text: 'Retour à mes annonces',
            )
          ],
        ),
      ),
    );
  }
}
