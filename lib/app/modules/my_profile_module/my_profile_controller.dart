import 'dart:developer';

import 'package:biker_app/app/data/api/api.checker.dart';
import 'package:biker_app/app/data/api/api_error.dart';
import 'package:biker_app/app/data/model/app_user.dart';
import 'package:biker_app/app/data/provider/app_auth_provider.dart';
import 'package:biker_app/app/modules/profile_module/profile_controller.dart';
import 'package:biker_app/app/utils/common.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfileController extends GetxController {
  final AppAuthProvider provider;
  MyProfileController({required this.provider});
  late ProfileController pController;

  final cityList = <String>[].obs;
  Rxn<String?> selectedCity = Rxn<String?>();

  TextEditingController fNameCtrl = TextEditingController();
  TextEditingController lNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController companyNameCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();

  String get fName => fNameCtrl.text.trim();
  String get lName => lNameCtrl.text.trim();
  String get email => emailCtrl.text.trim();
  String get companyName => companyNameCtrl.text.trim();
  String get address => addressCtrl.text.trim();
  String get desc => descCtrl.text.trim();
  String get phone => phoneCtrl.text.trim();

  RxString fNameErr = ''.obs;
  RxString lNameErr = ''.obs;
  RxString emailErr = ''.obs;
  RxString phoneErr = ''.obs;
  RxString cityErr = ''.obs;
  RxString companyNameErr = ''.obs;
  RxString addressErr = ''.obs;
  RxString descErr = ''.obs;

  onSelectCity(String val) => selectedCity.value = val;

  RxString logo = ''.obs;

  @override
  onInit() {
    pController = Get.find<ProfileController>();
    fNameCtrl.text = pController.appUser?.prenom ?? '';
    lNameCtrl.text = pController.appUser?.nom ?? '';
    emailCtrl.text = pController.appUser?.email ?? '';
    selectedCity.value = pController.appUser?.ville;
    phoneCtrl.text =
        pController.appUser?.telephone?.replaceAll('+212', '') ?? '';

    if (pController.appUser?.role == 'boutique') {
      companyNameCtrl.text = pController.appUser?.compName ?? '';
      addressCtrl.text = pController.appUser?.adresse ?? '';
      descCtrl.text = pController.appUser?.description ?? '';
      logo.value = pController.appUser?.logo ?? '';
    }
    super.onInit();
    getUser();
    getCities();
  }

  getCities() async {
    try {
      cityList.value = await provider.getCities();
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  updateUser() async {
    if (!formValidation()) return;
    Common.showLoading();

    try {
      await provider.updateUser(
        buildUserData(),
        logo: logo.value.isEmpty ? null : logo.value,
      );
      Get.back();
      Get.back();
      Common.showSuccess(title: 'profile_updated_successfully'.tr);
      getUser();
    } on ApiErrors catch (e) {
      Common.closeLoading();
      ApiChecker.checkApi(e);
    }
  }

  getUser() async {
    try {
      final user = await provider.getUser();
      storeUser(user);
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }

  storeUser(AppUser user) async {
    await Get.find<SharedPreferences>().setString(CACHED_USER, user.toJson());
    pController.setAppUser(user);
  }

  buildUserData() => {
    "nom": lName,
    "prenom": fName,
    "email": email,
    "telephone": '+212$phone',
    "ville": selectedCity.value!,
    "adresse": address,
    "description": desc,
    "nom_entreprise": companyName,
  };

  formValidation() {
    if (!GetUtils.isUsername(fName)) {
      fNameErr.value = 'invalid_first_name'.tr;
      return false;
    }
    if (!GetUtils.isUsername(lName)) {
      lNameErr.value = 'invalid_last_name'.tr;
      return false;
    }
    if (pController.appUser?.role == 'boutique' && companyName.isEmpty) {
      companyNameErr.value = 'Nom d\'entreprise invalide';
      return false;
    }
    if (selectedCity.value == null) {
      cityErr.value = 'please_select_city'.tr;
      return false;
    }
    if (!GetUtils.isEmail(email)) {
      emailErr.value = 'invalid_email'.tr;
      return false;
    }
    if (!GetUtils.isPhoneNumber('+212$phone')) {
      phoneErr.value = 'invalid_phone'.tr;
      return false;
    }

    if (pController.appUser?.role == 'boutique' && address.isEmpty) {
      addressErr.value = 'Adresse invalide'.tr;
      return false;
    }
    if (pController.appUser?.role == 'boutique' && desc.isEmpty) {
      descErr.value = 'Description invalide'.tr;
      return false;
    }
    return true;
  }

  void inputsListener() {
    fNameCtrl.addListener(() {
      if (fNameErr.isNotEmpty && GetUtils.isUsername(fName)) {
        fNameErr.value = '';
      }
    });
    lNameCtrl.addListener(() {
      if (lNameErr.isNotEmpty && GetUtils.isUsername(lName)) {
        lNameErr.value = '';
      }
    });
    phoneCtrl.addListener(() {
      if (phoneErr.isNotEmpty && phone.isNotEmpty) {
        phoneErr.value = '';
      }
    });
    emailCtrl.addListener(() {
      if (emailErr.isNotEmpty && GetUtils.isEmail(email)) {
        emailErr.value = '';
      }
    });
    companyNameCtrl.addListener(() {
      if (pController.appUser?.role == 'boutique' &&
          companyNameErr.isNotEmpty &&
          companyName.isNotEmpty) {
        companyNameErr.value = '';
      }
    });
    addressCtrl.addListener(() {
      if (pController.appUser?.role == 'boutique' &&
          addressErr.isNotEmpty &&
          address.isNotEmpty) {
        addressErr.value = '';
      }
    });
    descCtrl.addListener(() {
      if (pController.appUser?.role == 'boutique' &&
          descErr.isNotEmpty &&
          desc.isNotEmpty) {
        descErr.value = '';
      }
    });
  }

  void showLanguageBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Français'),
              onTap: () {
                Get.updateLocale(Locale('fr', 'FR'));
                Get.back();
              },
            ),
            ListTile(
              title: Text('العربية'),
              onTap: () {
                Get.updateLocale(Locale('ar', 'SA'));
                Get.back();
              },
            ),
            ListTile(
              title: Text('English'),
              onTap: () {
                Get.updateLocale(Locale('en', 'US'));
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  pickMedia() async {
    final files = await Common.getImagefromGallery(
      pickerType: PickerType.multiImage,
    );
    log('ach tma');
    if (files.isNotEmpty) {
      final compressImages = await Common.compressImages(files);
      logo.value = compressImages.first;
    }
  }
}
