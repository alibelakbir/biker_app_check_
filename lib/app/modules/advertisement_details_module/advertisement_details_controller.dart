import 'dart:developer';

import 'package:biker_app/app/data/api/api.checker.dart';
import 'package:biker_app/app/data/api/api_error.dart';
import 'package:biker_app/app/data/model/advertisement.dart';
import 'package:biker_app/app/data/model/premium_ad.dart';
import 'package:biker_app/app/data/model/shop.dart';
import 'package:biker_app/app/data/provider/premium_ads_provider.dart';
import 'package:biker_app/app/modules/advertisement_details_module/advertisement_details_page.dart';
import 'package:share_plus/share_plus.dart';
import 'package:biker_app/app/modules/shop_details_module/shop_details_page.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/services/appsflyer_service.dart';
import 'package:biker_app/app/utils/common.dart';
import 'package:biker_app/app/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:biker_app/app/utils/analytics_mixin.dart';
import '../../data/provider/advertisement_provider.dart';

class AdvertisementDetailsController extends GetxController
    with AnalyticsMixin {
  final AdvertisementProvider provider;
  final PremiumAdsProvider premiumAdsProvider;
  AdvertisementDetailsController({
    required this.provider,
    required this.premiumAdsProvider,
  });

  late final Rxn<Advertisement> _ad = Rxn<Advertisement>();
  Advertisement? get ad => _ad.value;

  final similarList = <Advertisement>[].obs;
  final bannerAd = Rxn<PremiumAd>();
  final iconAd = Rxn<PremiumAd>();

  late AdvertisementDetailsPage page;

  final Rxn<Shop> _seller = Rxn<Shop>();
  Shop? get seller => _seller.value;

  @override
  void onInit() {
    page = Get.arguments;
    if (page.ad != null) {
      _ad.value = page.ad;
      getMotoSimilaires();
      getSellerInfo();
    } else {
      adDetails();
    }
    getPremiumAd();
    getPremiumAdIcon();
    incrementerVuesMoto();

    // Log advertisement view with AppsFlyer
    if (page.ad != null) {
      AppsFlyerService.to.logAdvertisementView(
        page.ad!.id,
        page.isMoto ?? false ? 'moto' : 'equipment',
      );
    }

    super.onInit();

    // Track advertisement details page view
    trackPageView(
      pageName: 'Advertisement Details',
      parameters: {
        'ad_id': page.id,
        'is_moto': page.isMoto ?? false,
        'has_ad_data': page.ad != null,
      },
    );
  }

  adDetails() async {
    try {
      final result = await provider.adDetails(page.id, page.isMoto ?? false);
      _ad.value = result;
      getMotoSimilaires();
      getSellerInfo();

      // Log advertisement view with AppsFlyer
      AppsFlyerService.to.logAdvertisementView(
        result.id,
        page.isMoto ?? false ? 'moto' : 'equipment',
      );
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  getPremiumAd() async {
    try {
      bannerAd.value = await premiumAdsProvider.getPremiumAd(
        'detail',
        'banner',
      );
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  getPremiumAdIcon() async {
    try {
      iconAd.value = await premiumAdsProvider.getPremiumAd('detail', 'icone');
      reachPremiumAd(iconAd.value!.idpremiumads);
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  reachPremiumAd(int id) async {
    try {
      await premiumAdsProvider.reachPremiumAd(id);
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  getMotoSimilaires() async {
    try {
      final result = await provider.getMotoSimilaires(page.id, ad!.marque);
      similarList.value = result;
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  incrementerVuesMoto() async {
    try {
      await provider.incrementerVuesMoto(page.id, isMoto: page.isMoto ?? false);
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  onAddEvent(String type) async {
    switch (type) {
      case 'appel':
        Helpers.openTel(ad!.telephone);
        break;
      case 'chat':
        final currentUser = Get.find<FirebaseAuth>().currentUser;
        if (currentUser == null) {
          Get.toNamed(AppRoutes.auth);
          return;
        }
        log('go chat ${seller?.toJson()}');

        if (seller != null) {
          final userExist = await provider.userExists(seller!.uid);
          if (userExist) {
            Get.toNamed(
              AppRoutes.chat,
              arguments: {
                'receiverId': seller!.uid,
                'receiverName': ad!.nomvendeur,
                'receiverPhone': seller!.telephone,
                'ad': ad!.toMapAd(page.isMoto ?? false, page.category),
              },
            );
          } else {
            Common.showError(
              "Vous ne pouvez pas envoyer de message, car l'annonceur n'a pas l'application",
            );
          }
        }
      case 'whatsapp':
        Helpers.openWhatsappChat(
          seller!.telephone,
          message:
              "Bonjour, je vous contacte concernant cette annonce moto sur l'application biker.ma : \n${ad?.titre.toUpperCase()}",
        );
        break;
      default:
    }
    addEvent(type);
  }

  addEvent(type) async {
    try {
      await provider.addEvent(ad!.id, page.category, type);
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  shareAd() async {
    if (ad == null) return;
    final link = AppsFlyerService.to.generateAdvertisementDeepLink(
      advertisementId: ad!.id,
      type: page.isMoto ?? false ? 'moto' : 'equipment',
      category: page.category,
    );
    await Share.share(link, subject: 'Annonce Biker');
    addEvent('partage');
  }

  getSellerInfo() async {
    try {
      _seller.value = await provider.getInfoUtilisateur(ad!.idutilisateur);
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  onTapSeller() {
    log(seller?.toJson() ?? 'walo');
    if (seller == null) return;
    if (seller!.role == 'boutique') {
      Get.toNamed(
        AppRoutes.shopDetails,
        arguments: ShopDetailsPage(shop: seller!),
      );
    }
  }
}
