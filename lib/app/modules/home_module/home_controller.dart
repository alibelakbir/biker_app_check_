import 'package:biker_app/app/data/api/api.checker.dart';
import 'package:biker_app/app/data/api/api_error.dart';
import 'package:biker_app/app/data/model/advertisement.dart';
import 'package:biker_app/app/data/model/brand.dart';
import 'package:biker_app/app/data/model/premium_ad.dart';
import 'package:biker_app/app/data/provider/premium_ads_provider.dart';
import 'package:get/get.dart';
import 'package:biker_app/app/utils/analytics_mixin.dart';
import 'package:biker_app/app/data/provider/home_provider.dart';

class HomeController extends GetxController with AnalyticsMixin {
  HomeController({required this.provider, required this.premiumAdsProvider});
  final HomeProvider provider;
  final PremiumAdsProvider premiumAdsProvider;

  final motoAcceuilList = <Advertisement>[].obs;
  final motardList = <Advertisement>[].obs;
  final motoList = <Advertisement>[].obs;
  final pieceList = <Advertisement>[].obs;
  final pneuList = <Advertisement>[].obs;
  final brandList = <Brand>[].obs;
  final bannerAd = Rxn<PremiumAd>();

  @override
  void onInit() {
    //getBrands();
    getPremiumAd();
    getMotoAcceuil();
    getMotard();
    getMoto();
    getPiece();
    getPneu();
    super.onInit();

    // Track home page view
    trackPageView(pageName: 'Home');
  }

  getPremiumAd() async {
    try {
      final result = await premiumAdsProvider.getPremiumAd('home', 'banner');
      bannerAd.value = result;
      reachPremiumAd(result.idpremiumads);
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

  getMotoAcceuil() async {
    try {
      final result = await provider.getMotoAcceuil();
      motoAcceuilList.value = result;
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  getMotard() async {
    try {
      final result = await provider.getMotard();
      motardList.value = result;
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  getMoto() async {
    try {
      final result = await provider.getMoto();
      motoList.value = result;
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  getPiece() async {
    try {
      final result = await provider.getPiece();
      pieceList.value = result;
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  getPneu() async {
    try {
      final result = await provider.getPneu();
      pneuList.value = result;
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  getBrands() async {
    try {
      final result = await provider.getHomeBrands();
      brandList.value = result;
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }
}
