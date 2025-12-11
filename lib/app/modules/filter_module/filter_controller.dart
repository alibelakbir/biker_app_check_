import 'dart:developer';

import 'package:biker_app/app/data/api/api.checker.dart';
import 'package:biker_app/app/data/api/api_error.dart';
import 'package:biker_app/app/data/provider/brand_provider.dart';
import 'package:biker_app/app/modules/filter_module/widgets/model_input/model_input_controler.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/data/provider/filter_provider.dart';

class FilterController extends GetxController {
  final FilterProvider provider;
  final BrandProvider brandProvider;
  FilterController({required this.provider, required this.brandProvider});

  final cityList = <String>[].obs;

  TextEditingController modeleCtrl = TextEditingController();
  final RxString model = ''.obs;
  FocusNode modelNode = FocusNode();

  setModel(String val) {
    if (val.isEmpty) {
      modeleCtrl.clear();
      model.value = '';
    } else {
      model.value = val;
    }
  }

  late int categoryIndex;

  bool autoSearch = false;
  setAutoSearch(bool val) {
    autoSearch = val;
  }

  final catList = <String>[].obs;
  Rxn<String> selectedCategory = Rxn<String>();
  onSelectCategory(p0) {
    selectedCategory.value = p0;
  }

  Rxn<String?> selectedCity = Rxn<String?>();
  onSelectCity(String? val) {
    selectedCity.value = val;
  }

  final brandList = <String>[].obs;
  Rxn<String> selectedBrand = Rxn<String>();
  onSelectBrand(p0) {
    selectedBrand.value = p0;
  }

  Rxn<CylindreEnum?> cylendre = Rxn<CylindreEnum?>();
  onSelectCylindre(CylindreEnum? val) {
    cylendre.value = val;
  }

  Rx<RangeValues> kilometrageRange = RangeValues(0, filterMaxKm).obs;
  setkilometrageRange(RangeValues newRange) {
    kilometrageRange.value = newRange;
  }

  RangeValues? getKilometrage() {
    if (kilometrageRange.value.start == 0 &&
        kilometrageRange.value.end == filterMaxKm) {
      return null;
    }
    return kilometrageRange.value;
  }

  Rx<RangeValues> priceRange = RangeValues(0, filterMaxPrice).obs;
  setPriceRange(RangeValues newRange) {
    priceRange.value = newRange;
  }

  RangeValues? getPrice() {
    if (priceRange.value.start == 0 && priceRange.value.end == filterMaxPrice) {
      return null;
    }
    return priceRange.value;
  }

  onSetAutoSearch() {
    if (categoryIndex != 0) return;
    log(autoSearch.toString());
    if (autoSearch) {
      modelNode.requestFocus();
    } else {
      if (modelNode.hasFocus) {
        modelNode.unfocus();
      }
    }
  }

  @override
  void dispose() {
    modelNode.dispose();
    //modeleCtrl.dispose();
    super.dispose();
  }

  setCategoryIndex(int val) {
    categoryIndex = val;
    if (categoryIndex != 0 && categoryIndex != 3) {
      getCategories();
    } else {
      getBrands();
    }
    getCities();
  }

  getBrands() async {
    try {
      final result = await brandProvider.getBrandsByType('moto');
      brandList.value = result;
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  getCategories() async {
    // onSelectCategory(null);
    catList.clear();
    try {
      final result = await provider.getCategories(currentEqType());
      catList.value = result;
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  getCities() async {
    try {
      cityList.value = await provider.getCities();
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  onApplyFilter() {
    setModel(modeleCtrl.text.trim());
    Get.back(result: true);
  }

  onResetFilter() {
    onSelectCategory(null);
    onSelectBrand(null);
    onSelectCity(null);
    onSelectCylindre(null);
    setModel('');
    kilometrageRange.value = RangeValues(0, filterMaxKm);
    priceRange.value = RangeValues(0, filterMaxPrice);
  }

  String currentEqType() {
    switch (categoryIndex) {
      case 2:
        return 'moto';
      case 3:
        return 'pneu';
      case 4:
        return 'oil';
      case 5:
        return 'piece';
      default:
        return 'motard';
    }
  }
}
