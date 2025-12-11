// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:biker_app/app/data/api/api_error.dart';
import 'package:biker_app/app/data/provider/advertisement_provider.dart';
import 'package:biker_app/app/utils/analytics_mixin.dart';
import 'package:biker_app/app/utils/common.dart';

class ReportController extends GetxController with AnalyticsMixin {
  final AdvertisementProvider provider;
  final int adId;
  final bool isMoto;
  ReportController(
      {required this.provider, required this.adId, this.isMoto = false});

  var selectedReportMotif = Rx<Map<String, dynamic>?>(null);

  final descCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  final motifErr = ''.obs;

  report() async {
    if (selectedReportMotif.value == null) {
      motifErr.value = "Le motif est requis.";
      return;
    }
    Common.showLoading();
    try {
      await provider.reportAd(
          adId,
          selectedReportMotif.value!["title"],
          details: descCtrl.text.trim(),
          isMoto ? "moto" : "equipement",
          email: emailCtrl.text.trim(),
          phone: phoneCtrl.text.trim());
      Get.back();
      Get.back();
      descCtrl.clear();
      emailCtrl.clear();
      phoneCtrl.clear();
      Common.showSuccess(
          title: "Signalement reçu. Merci pour votre vigilance.");
    } on ApiErrors catch (_) {
      Get.back();
      Common.closeLoading();
      Common.showError("Signalement déjà enregistré récemment");
    }
  }

  onChangeReportMotif(p0) {
    selectedReportMotif.value = p0;
    if (motifErr.isNotEmpty && p0 != null) motifErr.value = '';
  }

  @override
  onClose() {
    descCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    super.onClose();
  }
}
