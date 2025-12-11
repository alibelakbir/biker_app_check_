// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:biker_app/app/modules/web_view.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/image_constants.dart';

class Menu {
  Widget icon;
  String label;
  Function()? onTap;
  bool isDanger;
  Menu(
      {required this.icon,
      required this.label,
      this.onTap,
      this.isDanger = false});

  Menu copyWith({
    Widget? icon,
    String? label,
    Function()? onTap,
    bool? isDanger,
  }) {
    return Menu(
      icon: icon ?? this.icon,
      label: label ?? this.label,
      onTap: onTap,
      isDanger: isDanger ?? this.isDanger,
    );
  }
}

List<Menu> myAccountList = [
  Menu(
      icon: Image.asset(ImageConstants.profil, width: 29),
      label: 'Mon Profil',
      onTap: () => Get.toNamed(AppRoutes.myProfile)),
  Menu(
      icon: Image.asset(ImageConstants.promotion, width: 29),
      label: 'Mes annonces',
      onTap: () => Get.toNamed(AppRoutes.myAdvertisement)),
  /* Menu(
      icon: Image.asset(ImageConstants.racing, width: 38, height: 21),
      label: 'Booster vos annonces',
      onTap: () {}), */
];

List myProfileList = [
  /*  Menu(
      icon: SvgImage(ImageConstants.bell, color: AppColors.black, width: 26),
      label: 'Notifications',
      onTap: () => Get.toNamed(AppRoutes.myProfile)), */
  Menu(
      icon: Image.asset(ImageConstants.cadenas, width: 26),
      label: 'Modifier votre mot de passe',
      onTap: () => Get.toNamed(AppRoutes.changePassword)),
  Menu(
      icon: Image.asset(ImageConstants.supprimer, width: 26),
      label: 'Supprimer mon compte',
      isDanger: true,
      onTap: () => Get.toNamed(AppRoutes.webView,
          arguments: WebViewScreen(
              url: EndPoints.deleteAccount,
              appBarText: 'Supprimer mon compte'))),
];

List otherList = [
  /*  Menu(
      icon: Image.asset(ImageConstants.langue, height: 25),
      label: 'Langue',
      onTap: () => Get.find<MyProfileController>().showLanguageBottomSheet()), */
  Menu(
      icon: Image.asset(ImageConstants.appel, height: 25),
      label: 'Contacter nous',
      onTap: () => Get.toNamed(AppRoutes.webView,
          arguments: WebViewScreen(
              url: EndPoints.contactPage, appBarText: 'Contacter nous'))),
  Menu(
      icon: Image.asset(ImageConstants.termesConditions, height: 25),
      label: 'Conditions d\'utilisation',
      onTap: () => Get.toNamed(AppRoutes.webView,
          arguments: WebViewScreen(
              url: EndPoints.conditionPolitique,
              appBarText: 'Conditions d\'utilisation'))),
  Menu(
      icon: Image.asset(ImageConstants.venteConditions, height: 25),
      label: 'Conditions de vente',
      onTap: () => Get.toNamed(AppRoutes.webView,
          arguments: WebViewScreen(
              url: EndPoints.conditionVente,
              appBarText: 'Conditions de vente'))),
];
