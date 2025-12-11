import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModelInputController extends GetxController {
  ModelInputController();

  TextEditingController modeleCtrl = TextEditingController();
  final RxString model = ''.obs;
  FocusNode modelNode = FocusNode();

  setModel(String val) {
    if (val.isEmpty) modeleCtrl.clear();
    model.value = val;
  }

  void unfocus() {
    if (modelNode.hasFocus) {
      modelNode.unfocus();
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    modelNode.dispose();
    modeleCtrl.dispose();
    super.dispose();
  }
}
