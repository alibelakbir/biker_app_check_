import 'package:biker_app/app/data/api/api.checker.dart';
import 'package:biker_app/app/data/api/api_error.dart';
import 'package:biker_app/app/data/model/premium_ad.dart';
import 'package:biker_app/app/data/model/response/ad_response.dart';
import 'package:biker_app/app/data/provider/brand_provider.dart';
import 'package:biker_app/app/data/provider/filter_provider.dart';
import 'package:biker_app/app/data/provider/premium_ads_provider.dart';
import 'package:biker_app/app/modules/filter_module/filter_controller.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../app/data/provider/listing_moto_provider.dart';
import 'package:biker_app/app/utils/analytics_mixin.dart';

class ListingMotoController extends GetxController
    with GetSingleTickerProviderStateMixin, AnalyticsMixin {
  final ListingMotoProvider provider;
  final PremiumAdsProvider premiumAdsProvider;
  ListingMotoController({
    required this.provider,
    required this.premiumAdsProvider,
  });

  late TabController tabController;
  RxInt tabIndex = 0.obs;

  Rxn<AdResponse> motoResponse = Rxn<AdResponse>();
  Rxn<AdResponse> eqResponse = Rxn<AdResponse>();

  RefreshController motoRefreshCntr = RefreshController();
  RefreshController eqRefreshCntr = RefreshController();
  final ScrollController scrollController = ScrollController();

  late FilterController fController;

  final premiumAds = <PremiumAd>[].obs;
  int adInterval = 7;

  RxBool isLoadingMoto = false.obs;
  RxBool isLoadingEq = false.obs;

  void changeTabIndex(int val) {
    tabIndex.value = val;
    fController.onResetFilter();
    switch (tabIndex.value) {
      case 0:
        if (motoResponse.value == null) {
          getAnnonceMoto();
        }
        break;
      default:
        getAnnonceEquipement();
    }
  }

  @override
  void onInit() {
    var params = Get.arguments;

    tabController = TabController(
      initialIndex: params != null ? params['index'] as int : 0,
      length: 6,
      vsync: this,
    );

    fController = Get.put(
      FilterController(
        provider: FilterProvider(),
        brandProvider: BrandProvider(),
      ),
    );

    if (params != null) {
      changeTabIndex(params['index'] as int);
    } else {
      getAnnonceMoto();
    }

    super.onInit();

    // Track listing moto page view
    trackPageView(
      pageName: 'Listing Moto',
      parameters: {
        'initial_tab': params != null ? params['index'] as int : 0,
        'total_tabs': 6,
      },
    );

    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        changeTabIndex(tabController.index);
      }
    });
    getPremiumAds();
  }

  getPremiumAds() async {
    try {
      premiumAds.value = await premiumAdsProvider.getPremiumAds();
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  getAnnonceMoto() async {
    isLoadingMoto.value = true;
    try {
      final result = await provider.getAnnonceMoto(
        marque: fController.selectedBrand.value,
        modele: fController.model.value,
        kilometragemin: fController.getKilometrage()?.start.toInt(),
        kilometragemax: fController.getKilometrage()?.end.toInt(),
        prixmin: fController.getPrice()?.start.toInt(),
        prixmax: fController.getPrice()?.end.toInt(),
        ville: fController.selectedCity.value,
        cylindre: fController.cylendre.value?.name,
      );
      isLoadingMoto.value = false;
      motoResponse.value = result;
      if (scrollController.offset > 0) {
        scrollController.jumpTo(0);
      }
    } on ApiErrors catch (e) {
      isLoadingMoto.value = false;
      ApiChecker.checkApi(e);
    }
  }

  getAnnonceEquipement() async {
    isLoadingEq.value = true;

    try {
      final result = await provider.getAnnonceEquipement(
        type: currentEqType(),
        category: fController.selectedCategory.value,
        prixmin: fController.getPrice()?.start.toInt(),
        prixmax: fController.getPrice()?.end.toInt(),
        ville: fController.selectedCity.value,
      );
      isLoadingEq.value = false;
      eqResponse.value = result;
      if (scrollController.offset > 0) {
        scrollController.jumpTo(0);
      }
    } on ApiErrors catch (e) {
      isLoadingEq.value = true;
      ApiChecker.checkApi(e);
    }
  }

  void onLoadingMoto() async {
    if (isMotoReachedMax()) {
      motoRefreshCntr.loadNoData();
      return;
    }
    motoResponse.value!.page++;
    try {
      final result = await provider.getAnnonceMoto(
        page: motoResponse.value!.page,
        marque: fController.selectedBrand.value,
        modele: fController.model.value,
        kilometragemin: fController.kilometrageRange.value.start.toInt(),
        kilometragemax: fController.kilometrageRange.value.end.toInt(),
        prixmin: fController.getPrice()?.start.toInt(),
        prixmax: fController.getPrice()?.end.toInt(),
        ville: fController.selectedCity.value,
        cylindre: fController.cylendre.value?.name,
      );
      motoResponse.value!.annonces.addAll(result.annonces);
      //motoResponse.value!.page = result.page;
      motoResponse.value!.totalPages = result.totalPages;

      motoResponse.refresh();

      motoRefreshCntr.loadComplete();
    } on ApiErrors catch (_) {
      motoRefreshCntr.loadFailed();
    }
  }

  bool isMotoReachedMax() =>
      motoResponse.value!.annonces.length == motoResponse.value!.totalPages;

  //------------------------------------------------------------------------

  void onLoadingEquipement() async {
    if (isMotoReachedMax()) {
      eqRefreshCntr.loadNoData();
      return;
    }
    eqResponse.value!.page++;
    try {
      final result = await provider.getAnnonceEquipement(
        type: currentEqType(),
        page: eqResponse.value!.page,
        category: fController.selectedCategory.value,
        prixmin: fController.getPrice()?.start.toInt(),
        prixmax: fController.getPrice()?.end.toInt(),
        ville: fController.selectedCity.value,
      );
      eqResponse.value!.annonces.addAll(result.annonces);
      //motoResponse.value!.page = result.page;
      eqResponse.value!.totalPages = result.totalPages;

      eqResponse.refresh();

      eqRefreshCntr.loadComplete();
    } on ApiErrors catch (_) {
      motoRefreshCntr.loadFailed();
    }
  }

  bool isEqReachedMax() =>
      eqResponse.value!.annonces.length == eqResponse.value!.totalPages;

  String currentEqType() {
    switch (tabIndex.value) {
      case 2:
        return 'moto';
      case 3:
        return 'pneu';
      case 4:
        return 'piece';
      case 5:
        return 'oil';

      default:
        return 'motard';
    }
  }

  Future<void> goFilter({autoSearch = false}) async {
    fController.setCategoryIndex(tabIndex.value);
    fController.setAutoSearch(autoSearch);
    fController.onSetAutoSearch();

    await Get.toNamed(AppRoutes.filter);
    if (tabIndex.value == 0) {
      getAnnonceMoto();
    } else {
      getAnnonceEquipement();
    }
  }

  void onLoading() {
    if (tabIndex.value == 0) {
      onLoadingMoto();
    } else {
      onLoadingEquipement();
    }
  }

  void onRefresh() {
    if (tabIndex.value == 0) {
      getAnnonceMoto();
    } else {
      getAnnonceEquipement();
    }
  }

  bool isAdIndex(int index) {
    // Only treat as an ad slot if we still have an ad to show at this position
    if ((index + 1) % (adInterval + 1) != 0) return false;
    final adIndex = (index + 1) ~/ (adInterval + 1) - 1;
    return adIndex >= 0 && adIndex < premiumAds.length;
  }

  int adsBeforeIndex(int index) {
    // Count only actually inserted ads before this index, capped by available ads
    final potential = (index + 1) ~/ (adInterval + 1);
    return potential > premiumAds.length ? premiumAds.length : potential;
  }

  int numberOfAdsToInsert() {
    // Insert at most the number of available premium ads
    final potential = motoResponse.value!.annonces.length ~/ adInterval;
    return potential > premiumAds.length ? premiumAds.length : potential;
  }
}
