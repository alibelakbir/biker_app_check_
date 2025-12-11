import 'package:biker_app/app/modules/web_view.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';

class CguWidget extends StatelessWidget {
  const CguWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: AppTextStyles.base.s11.w400.blackColor,
        text:
            "* En vous connectant à la plateforme Biker.ma, vous acceptez les ",
        children: [
          TextSpan(
            text: "CGU",
            style: AppTextStyles.base.s11.w600.blackColor,
            recognizer:
                TapGestureRecognizer()
                  ..onTap =
                      () => Get.toNamed(
                        AppRoutes.webView,
                        arguments: WebViewScreen(
                          url: EndPoints.conditionPolitique,
                          appBarText: 'Conditions d\'utilisation',
                        ),
                      ),
          ),
          TextSpan(text: " et les "),
          TextSpan(
            text: "CGV",
            style: AppTextStyles.base.s11.w600.blackColor,
            recognizer:
                TapGestureRecognizer()
                  ..onTap =
                      () => Get.toNamed(
                        AppRoutes.webView,
                        arguments: WebViewScreen(
                          url: EndPoints.conditionVente,
                          appBarText: 'Conditions de vente',
                        ),
                      ),
          ),
          TextSpan(
            text:
                ", incluant la mention relative à la protection des données personnelles.\n* Conformément à la loi 09-08, vous disposez d’un droit d’accès, de rectification et d’opposition au traitement de vos données personnelles. Ce traitement est autorisé par la CNDP sous le n° ",
          ),
          TextSpan(
            text: "D-W-1313/2025",
            style: AppTextStyles.base.s11.w600.blackColor,
          ),
        ],
      ),
    );
  }
}
