import 'dart:developer';

import 'package:biker_app/app/data/api/api.checker.dart';
import 'package:biker_app/app/data/api/api_error.dart';
import 'package:biker_app/app/data/model/response/ad_response.dart';
import 'package:biker_app/app/data/provider/advertisement_provider.dart';
import 'package:biker_app/app/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAdvertisementController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final AdvertisementProvider provider;
  MyAdvertisementController({required this.provider});

  late TabController tabController;
  RxInt tabIndex = 0.obs;

  Rxn<AdResponse> motoResponse = Rxn<AdResponse>();
  Rxn<AdResponse> eqMotardResponse = Rxn<AdResponse>();
  Rxn<AdResponse> eqMotoResponse = Rxn<AdResponse>();
  Rxn<AdResponse> pneuResponse = Rxn<AdResponse>();
  Rxn<AdResponse> pieceResponse = Rxn<AdResponse>();
  Rxn<AdResponse> oilResponse = Rxn<AdResponse>();

  void changeTabIndex(int val) {
    tabIndex.value = val;
    tabData();
  }

  tabData() {
    switch (tabIndex.value) {
      case 0:
        getMoto();
        break;
      case 1:
        geEqMotard();
        break;
      case 2:
        geEqMoto();
        break;
      case 3:
        geEqPneu();
        break;
      case 4:
        geEqPiece();
        break;
      case 5:
        getEqOil();
        break;
      default:
    }
  }

  @override
  void onInit() {
    tabController = TabController(length: 6, vsync: this);

    getMoto();
    super.onInit();

    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        changeTabIndex(tabController.index);
      }
    });
  }

  getMoto() async {
    try {
      final result = await provider.mesAnnonceMoto();
      motoResponse.value = result;
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  geEqMotard() async {
    try {
      final result = await provider.mesAnnonce(type: 'motard');
      eqMotardResponse.value = result;
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  geEqMoto() async {
    try {
      final result = await provider.mesAnnonce(type: 'moto');
      eqMotoResponse.value = result;
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  geEqPneu() async {
    try {
      final result = await provider.mesAnnonce(type: 'pneu');
      pneuResponse.value = result;
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  geEqPiece() async {
    try {
      final result = await provider.mesAnnonce(type: 'piece');
      pieceResponse.value = result;
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  getEqOil() async {
    try {
      final result = await provider.mesAnnonce(type: 'oil');
      oilResponse.value = result;
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  disableAnnce(int id) async {
    log('id here: $id');
    Common.showLoading();
    try {
      await provider.disableAnnonce(id, tabIndex.value == 0);
      tabData();
      Get.back();
      Common.showSuccess(title: 'Annonce désactivée avec succès');
    } on ApiErrors catch (e) {
      Common.closeLoading();
      ApiChecker.checkApi(e);
    }
  }
}
