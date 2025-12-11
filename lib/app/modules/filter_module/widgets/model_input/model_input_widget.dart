import 'package:biker_app/app/modules/filter_module/widgets/model_input/model_input_controler.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/widgets/inputs/name_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModelInputWidget extends GetWidget<ModelInputController> {
  final int categoryIndex;
  const ModelInputWidget(this.categoryIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    return categoryIndex != 0  ?SizedBox.shrink(): NameInput(
      controller: controller.modeleCtrl,
      focusNode: controller.modelNode,
      title: 'Modèle',
      hint: 'Modèle',
      titleStyle: AppTextStyles.base.s16.w600.blackColor,
      textInputAction: TextInputAction.done,
    ).paddingSymmetric(vertical: 10);
  }
}
