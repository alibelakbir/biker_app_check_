import 'dart:developer';

import 'package:biker_app/app/data/api/api.checker.dart';
import 'package:biker_app/app/data/api/api_error.dart';
import 'package:biker_app/app/data/model/advertisement.dart';
import 'package:biker_app/app/data/provider/brand_provider.dart';
import 'package:biker_app/app/modules/profile_module/profile_controller.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/utils/common.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/enums.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../app/data/provider/new_advertisement_provider.dart';
import 'package:biker_app/app/utils/analytics_mixin.dart';

class NewAdvertisementController extends GetxController with AnalyticsMixin {
  final NewAdvertisementProvider provider;
  final BrandProvider brandProvider;
  NewAdvertisementController({
    required this.provider,
    required this.brandProvider,
  });

  final PageController pageController = PageController();
  RxInt pageIndex = 0.obs;

  Advertisement? advertisement;

  final cityList = <String>[].obs;

  RxBool firstHand = false.obs;
  setFirstHand() => firstHand.value = !firstHand.value;

  TextEditingController modeleCtrl = TextEditingController();
  TextEditingController anneeModeleCtrl = TextEditingController();
  TextEditingController anneeCirculationCtrl = TextEditingController();
  TextEditingController cylindreCtrl = TextEditingController();
  TextEditingController kilomtrageCtrl = TextEditingController();
  TextEditingController titreCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();
  TextEditingController prixCtrl = TextEditingController();
  TextEditingController dimCtrl = TextEditingController();
  TextEditingController sellerNameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController brandCtrl = TextEditingController();

  String get sellerName => sellerNameCtrl.text.trim();
  String get phone => phoneCtrl.text.trim();

  RxString sellerNameErr = ''.obs;
  RxString phoneErr = ''.obs;

  Rxn<int> selectedType = Rxn<int>();
  onSelectType(p0) {
    selectedType.value = p0;
    if (selectedType.value != null) pageController.jumpToPage(1);
    if (selectedType.value != null &&
        (selectedType.value == 1 ||
            selectedType.value == 2 ||
            selectedType.value == 4)) {
      getCategories();
    }
  }

  final catList = <String>[].obs;
  Rxn<String> selectedCategory = Rxn<String>();
  onSelectCategory(p0) {
    selectedCategory.value = p0;
    if (categoryErr.isNotEmpty) categoryErr.value = '';
  }

  final brandList = <String>[].obs;
  Rxn<String> selectedBrand = Rxn<String>();
  onSelectBrand(p0) {
    selectedBrand.value = p0;
    if (brandErr.isNotEmpty) brandErr.value = '';
  }

  Rxn<String> selectedOrigine = Rxn<String>();
  onSelectOrigine(p0) {
    selectedOrigine.value = p0;
    if (origineErr.isNotEmpty) origineErr.value = '';
  }

  Rxn<String> selectedEtat = Rxn<String>();
  onSelectEtat(p0) {
    selectedEtat.value = p0;
    if (etatErr.isNotEmpty) etatErr.value = '';
  }

  Rxn<String> selectedMotorisation = Rxn<String>();
  onSelectMotorisation(p0) {
    selectedMotorisation.value = p0;
    if (motorisationErr.isNotEmpty) motorisationErr.value = '';
  }

  Rxn<String?> selectedCity = Rxn<String?>();
  onSelectCity(String val) {
    selectedCity.value = val;
    if (cityErr.isNotEmpty) cityErr.value = '';
  }

  String get model => modeleCtrl.text.trim();
  String get anneeModel => anneeModeleCtrl.text.trim();
  String get anneeCirculation => anneeCirculationCtrl.text.trim();
  String get cylindre => cylindreCtrl.text.trim();
  String get kilomtrage => kilomtrageCtrl.text.trim();
  String get titre => titreCtrl.text.trim();
  String get desc => descCtrl.text.trim();
  String get prix => prixCtrl.text.trim();
  String get dimensions => dimCtrl.text.trim();
  String get brand => brandCtrl.text.trim();

  final medias = <String>[
    '',
    '',
    '',
    '',
    '',
    '',
  ].obs;
  final deletedMedias = [];

  RxString categoryErr = ''.obs;
  RxString brandErr = ''.obs;
  RxString modeleErr = ''.obs;
  RxString anneeModelErr = ''.obs;
  RxString anneeCirculationErr = ''.obs;
  RxString motorisationErr = ''.obs;
  RxString cylindreErr = ''.obs;
  RxString kilometrageErr = ''.obs;
  RxString origineErr = ''.obs;
  RxString etatErr = ''.obs;
  RxString titreErr = ''.obs;
  RxString descErr = ''.obs;
  RxString prixErr = ''.obs;
  RxString mediaErr = ''.obs;
  RxString cityErr = ''.obs;

  setPageIndex(int value) {
    pageIndex.value = value;
  }

  @override
  void onInit() {
    getBrands();
    super.onInit();

    // Track new advertisement page view
    trackPageView(pageName: 'New Advertisement');

    inputsListener();
  }

  @override
  onReady() {
    super.onReady();
    advertisement = Get.arguments as Advertisement?;

    if (advertisement != null) {
      onSelectType(
        categoryList.indexWhere((e) => e['type'] == advertisement!.type),
      );
      editAd(advertisement!);
    }
  }

  addAnnonce() {
    Get.offNamed(AppRoutes.congratulations);
  }

  onTapNext() {
    switch (pageIndex.value) {
      case 1:
        if (validateForm1()) pageController.jumpToPage(2);
      case 2:
        if (validateForm2()) pageController.jumpToPage(3);
      case 3:
        if (validateMedias()) {
          pageController.jumpToPage(4);
          getCities();
        }
      case 4:
        if (validateSellerInfo()) addAnnonceMoto();
      default:
    }
  }

  onTapPrevious() {
    pageController.jumpToPage(pageIndex.value - 1);
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
    try {
      final result = await provider.getCategories(
        selectedType.value == 1
            ? 'motard'
            : selectedType.value == 2
                ? 'moto'
                : 'piece',
      );
      catList.value = result;
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  getCities() async {
    final pController = Get.find<ProfileController>();
    try {
      cityList.value = await provider.getCities();
      if (Get.arguments == null) {
        selectedCity.value = pController.appUser?.ville;
        sellerNameCtrl.text = pController.appUser?.nom ?? '';
        phoneCtrl.text =
            pController.appUser?.telephone?.replaceAll('+212', '') ?? '';
      }
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  pickMedia(int index) async {
    final files =
        await Common.getImagefromGallery(pickerType: PickerType.multiImage);
    if (files.isNotEmpty) {
      final compressImages = await Common.compressImages(
        files.length > 6 ? files.sublist(0, 6) : files,
      );
      medias[index] = compressImages.first;
      if (mediaErr.isNotEmpty) mediaErr.value = '';
    }
  }

  addAnnonceMoto() async {
    Common.showLoading();
    try {
      advertisement == null
          ? await provider.addAnnonce(
              medias
                  .whereType<String>()
                  .where((media) => media.trim().isNotEmpty)
                  .toList(),
              buildAnnonce(),
              selectedType.value!,
            )
          : await provider.editAnnonce(
              advertisement!.id,
              medias
                  .whereType<String>()
                  .where((media) => media.trim().isNotEmpty)
                  .toList(),
              buildAnnonce(),
              selectedType.value!,
              deletedImages: deletedMedias);
      Get.back();
      Get.offNamed(AppRoutes.congratulations);
    } on ApiErrors catch (e) {
      Common.closeLoading();
      ApiChecker.checkApi(e);
    }
  }

  bool validateForm1() {
    if ((selectedType.value == 1 ||
            selectedType.value == 2 ||
            selectedType.value == 4) &&
        selectedCategory.value == null) {
      categoryErr.value = "category_required".tr;
      return false;
    }
    if ((selectedType.value == 0 && selectedBrand.value == null) ||
        (selectedType.value != 0 && brand.isEmpty)) {
      brandErr.value = "brand_required".tr;
      return false;
    }
    if (selectedType.value == 0 && modeleCtrl.text.isEmpty) {
      modeleErr.value = "model_required".tr;
      return false;
    }
    if (selectedType.value == 0 &&
        !GetUtils.isNumericOnly(anneeModeleCtrl.text)) {
      anneeModelErr.value = "model_year_required".tr;
      return false;
    }
    if (selectedType.value == 0 &&
        anneeCirculationCtrl.text.isNotEmpty &&
        int.parse(anneeCirculationCtrl.text) <
            int.parse(anneeModeleCtrl.text)) {
      anneeModelErr.value =
          "L'année de circulation ne peut pas être inférieure à l'année du modèle";
      return false;
    }
    if (selectedType.value == 0 && selectedMotorisation.value == null) {
      motorisationErr.value = "motorization_required".tr;
      return false;
    }
    if (selectedType.value == 0 && !GetUtils.isNumericOnly(cylindreCtrl.text)) {
      cylindreErr.value = "cylinder_required".tr;
      return false;
    }
    if (selectedType.value == 0 &&
        !GetUtils.isNumericOnly(kilomtrageCtrl.text)) {
      kilometrageErr.value = "mileage_required".tr;
      return false;
    }
    if (selectedType.value == 0 && selectedOrigine.value == null) {
      origineErr.value = "origin_required".tr;
      return false;
    }
    if (selectedType.value != 5 && selectedEtat.value == null) {
      etatErr.value = "condition_required".tr;
      return false;
    }
    return true;
  }

  validateForm2() {
    if (titreCtrl.text.isEmpty) {
      titreErr.value = "title_required".tr;
      return false;
    }
    if (descCtrl.text.isEmpty) {
      descErr.value = "description_required".tr;
      return false;
    }
    if (prix.isNotEmpty && !GetUtils.isNumericOnly(prix)) {
      prixErr.value = "price_must_be_positive".tr;
      return false;
    }
    return true;
  }

  bool validateMedias() {
    log('meddd');
    if (medias.isEmpty) {
      mediaErr.value = "ad_photo_required".tr;
      return false;
    }
    if (medias[0].isEmpty) {
      mediaErr.value = "La photo principale est obligatoire";
      return false;
    }
    return true;
  }

  bool validateSellerInfo() {
    if (selectedCity.value == null || selectedCity.value!.isEmpty) {
      cityErr.value = 'city_required'.tr;
      return false;
    }
    if (!GetUtils.isUsername(sellerName)) {
      sellerNameErr.value = 'seller_name_required'.tr;
      return false;
    }
    if (!GetUtils.isPhoneNumber('+212$phone')) {
      phoneErr.value = 'phone_required'.tr;
      return false;
    }

    return true;
  }

  void inputsListener() {
    modeleCtrl.addListener(() {
      if (model.isNotEmpty) {
        modeleErr.value = '';
      }
    });
    anneeModeleCtrl.addListener(() {
      if (GetUtils.isNumericOnly(anneeModel)) {
        modeleErr.value = '';
      }
    });
    cylindreCtrl.addListener(() {
      if (GetUtils.isNumericOnly(cylindre)) {
        cylindreErr.value = '';
      }
    });
    kilomtrageCtrl.addListener(() {
      if (GetUtils.isNumericOnly(kilomtrage)) {
        kilometrageErr.value = '';
      }
    });
    titreCtrl.addListener(() {
      if (titre.isNotEmpty) {
        titreErr.value = '';
      }
    });
    descCtrl.addListener(() {
      if (desc.isNotEmpty) {
        descErr.value = '';
      }
    });
    prixCtrl.addListener(() {
      if (prixErr.isNotEmpty &&
          prix.isNotEmpty &&
          GetUtils.isNumericOnly(prix)) {
        prixErr.value = '';
      }
    });
    sellerNameCtrl.addListener(() {
      if (sellerNameErr.isNotEmpty && sellerName.isNotEmpty) {
        sellerNameErr.value = '';
      }
    });
    phoneCtrl.addListener(() {
      if (phoneErr.isNotEmpty && GetUtils.isPhoneNumber('+212$phone')) {
        phoneErr.value = '';
      }
    });
  }

  buildAnnonce() {
    var annonce = Advertisement(
      id: advertisement?.id ?? 0,
      idutilisateur: 0,
      marque: selectedType.value == 0 ? selectedBrand.value! : brand,
      dateajout: '',
      etat: selectedType.value == 5 ? '' : selectedEtat.value!,
      etatannonce: '',
      titre: titre,
      description: desc,
      prix: prix.isNotEmpty ? num.parse(prix) : null,
      ville: selectedCity.value!,
      telephone: '+212$phone',
      nomvendeur: sellerName,
      medias: medias,
      role: 'particulier',
      vendu: 0,
    );
    if (selectedType.value == 0) {
      annonce.model = model;
      annonce.anneemodele = int.parse(anneeModel);
      annonce.anneecirculation = int.parse(anneeCirculation);
      annonce.cylindre = cylindre;
      annonce.kilometrage = int.parse(kilomtrage);
      annonce.motorisation = selectedMotorisation.value!;
      annonce.premieremain = firstHand.value ? 1 : 0;
      annonce.origine = selectedOrigine.value!;
    }
    if (selectedType.value != 0) {
      annonce.type = categoryList[selectedType.value!]['type'];
    }
    annonce.categorie = selectedCategory.value;
    annonce.dimensions = dimensions;
    return annonce;
  }

  void editAd(Advertisement params) {
    firstHand.value = params.premieremain != null && params.premieremain == 1;
    if (selectedType.value == 0) {
      selectedBrand.value = params.marque;
    } else {
      brandCtrl.text = params.marque;
      selectedCategory.value = params.categorie;
    }
    dimCtrl.text = params.dimensions ?? '';
    modeleCtrl.text = params.model ?? '';
    cylindreCtrl.text = params.cylindre ?? '';
    selectedMotorisation.value = params.motorisation;
    selectedOrigine.value = params.origine;
    anneeModeleCtrl.text = params.anneemodele?.toString() ?? '';
    anneeCirculationCtrl.text = params.anneecirculation?.toString() ?? '';
    kilomtrageCtrl.text = params.kilometrage?.toString() ?? '';
    selectedEtat.value = params.etat;
    titreCtrl.text = params.titre;
    descCtrl.text = params.description;
    prixCtrl.text = params.prix?.toString() ?? '';
    selectedCity.value = params.ville;
    sellerNameCtrl.text = params.nomvendeur;
    phoneCtrl.text = params.telephone.replaceAll('+212', '');
    log(params.medias.toString());
    for (int i = 0; i < params.medias.length; i++) {
      if (params.medias[i] != null &&
          params.medias[i] is String &&
          params.medias[i]!.isNotEmpty) {
        medias[i] = EndPoints.mediaUrl(params.medias[i])!;
      }
    }

    /*  medias.value = params.medias
        .whereType<String>()
        .toList()
        .map((e) => EndPoints.mediaUrl(e)!)
        .toList(); */
  }

  removeMedia(int index) {
    if (medias[index].contains('http')) {
      deletedMedias.add({'deletePhoto${index + 1}': 'true'});
    }
    medias[index] = '';
    for (var d in deletedMedias) {
      log(d.toString());
    }
  }
}
