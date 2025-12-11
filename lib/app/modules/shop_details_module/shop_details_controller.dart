import 'package:biker_app/app/data/api/api.checker.dart';
import 'package:biker_app/app/data/api/api_error.dart';
import 'package:biker_app/app/data/model/advertisement.dart';
import 'package:biker_app/app/data/model/shop.dart';
import 'package:biker_app/app/modules/shop_details_module/shop_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/data/provider/shop_details_provider.dart';

class ShopDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ShopDetailsProvider provider;
  ShopDetailsController({required this.provider});

  late TabController tabController;
  RxInt tabIndex = 0.obs;

  final Rxn<Shop> _shop = Rxn<Shop>();
  Shop? get shop => _shop.value;

  final productList = <Advertisement>[].obs;

  late ShopDetailsPage page;

  void changeTabIndex(int val) {
    tabIndex.value = val;
    getShopProducts();
    switch (tabIndex.value) {
      case 0:
        break;
      default:
    }
  }

  @override
  onInit() {
    page = Get.arguments;
    _shop.value = page.shop;
    tabController = TabController(length: 6, vsync: this);
    //getShop();
    getShopProducts();
    super.onInit();

    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        changeTabIndex(tabController.index);
      }
    });
  }

  getShop() async {
    try {
      final result = await provider.getShop(page.shop.idutilisateur);
      _shop.value = result;
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  getShopProducts() async {
    try {
      final result =
          await provider.getShopProducts(page.shop.idutilisateur, getType());
      productList.value = result;
    } on ApiErrors catch (e) {
      productList.clear();
      ApiChecker.checkApi(e);
    }
  }

  String getType() {
    switch (tabIndex.value) {
      case 1:
        return 'equipement/boutique/motard';
      case 2:
        return 'equipement/boutique/moto';
      case 3:
        return 'equipement/boutique/pneu';
      case 4:
        return 'equipement/boutique/piece';
      case 5:
        return 'equipement/boutique/huile';
      default:
        return 'moto/boutique';
    }
  }
}
