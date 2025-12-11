
import 'package:biker_app/app/modules/new_advertisement_module/new_advertisement_controller.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/widgets/inputs/custom_dropdown_search.dart';
import 'package:biker_app/app/utils/widgets/inputs/custom_dropdown_widget.dart';
import 'package:biker_app/app/utils/widgets/inputs/name_input.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class Tab1 extends GetWidget<NewAdvertisementController> {
  const Tab1({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 32, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            controller.selectedType.value == 0
                ? GestureDetector(
                    onTap: () => controller.setFirstHand(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 8,
                      children: [
                        Obx(
                          () => RoundCheckBox(
                            isChecked: controller.firstHand.value,
                            size: 24,
                            onTap: (_) => controller.setFirstHand(),
                            checkedColor: AppColors.kPrimaryColor,
                            uncheckedColor: AppColors.transparent,
                            checkedWidget: const Icon(
                              Icons.check,
                              size: 16,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        Text(
                          'Première main',
                          style: AppTextStyles.base.s14.w500.blackColor,
                        )
                      ],
                    ),
                  ).paddingSymmetric(vertical: 10)
                : SizedBox.shrink(),
            controller.selectedType.value == 1 ||
                    controller.selectedType.value == 2 ||
                    controller.selectedType.value == 4
                ? Obx(() => CustomDropdownWidget(
                      bgColor: Color(0xFFF4F4F4),
                      value: controller.selectedCategory.value,
                      title: 'Catégorie',
                      hint: 'Choisr la catégorie',
                      items: controller.catList
                          .map<DropdownMenuItem<String>>((String val) =>
                              DropdownMenuItem<String>(
                                value: val,
                                child: Text(
                                  val,
                                  style: AppTextStyles.base.s13.w400.blackColor,
                                ),
                              ))
                          .toList(),
                      onChaged: (p0) => controller.onSelectCategory(p0),
                      textErr: controller.categoryErr.isNotEmpty
                          ? controller.categoryErr.value
                          : '',
                    ).paddingSymmetric(vertical: 10))
                : SizedBox.shrink(),
            Obx(
              () => controller.selectedType.value != 0
                  ? NameInput(
                      controller: controller.brandCtrl,
                      title: 'Marque',
                      hint: '',
                      errorText: controller.brandErr.isNotEmpty
                          ? controller.brandErr.value
                          : null,
                    ).paddingSymmetric(vertical: 10)
                  : CustomDropdownSearch(
                      title: 'Marque',
                      hint: 'Choisr la marque',
                      items: controller.brandList,
                      value: controller.selectedBrand.value,
                      onChaged: (p0) => controller.onSelectBrand(p0),
                      textErr: controller.brandErr.isNotEmpty
                          ? controller.brandErr.value
                          : '',
                    ).paddingSymmetric(vertical: 10),

              /*  CustomDropdownWidget(
                      bgColor: Color(0xFFF4F4F4),
                      value: controller.selectedBrand.value,
                      title: 'Marque',
                      hint: 'Choisr la marque',
                      items: controller.brandList
                          .map<DropdownMenuItem<String>>((String val) =>
                              DropdownMenuItem<String>(
                                value: val,
                                child: Text(
                                  val,
                                  style: AppTextStyles.base.s13.w400.blackColor,
                                ),
                              ))
                          .toList(),
                      onChaged: (p0) => controller.onSelectBrand(p0),
                      textErr: controller.brandErr.isNotEmpty
                          ? controller.brandErr.value
                          : '',
                    ).paddingSymmetric(vertical: 10), */
            ),
            controller.selectedType.value != 0 &&
                    controller.selectedType.value != 5
                ? NameInput(
                    controller: controller.dimCtrl,
                    title: 'Taille/Dimensions',
                    hint: '',
                  ).paddingSymmetric(vertical: 10)
                : SizedBox.shrink(),
            controller.selectedType.value == 0
                ? Obx(() => NameInput(
                      controller: controller.modeleCtrl,
                      title: 'model',
                      hint: '',
                      errorText: controller.modeleErr.isNotEmpty
                          ? controller.modeleErr.value
                          : null,
                    ).paddingSymmetric(vertical: 10))
                : SizedBox.shrink(),
            controller.selectedType.value == 0
                ? Obx(() => NameInput(
                      textInputType: TextInputType.number,
                      controller: controller.cylindreCtrl,
                      title: 'cylinder',
                      hint: '',
                      errorText: controller.cylindreErr.isNotEmpty
                          ? controller.cylindreErr.value
                          : null,
                    ).paddingSymmetric(vertical: 10))
                : SizedBox.shrink(),
            controller.selectedType.value == 0
                ? Obx(() => CustomDropdownWidget(
                      value: controller.selectedMotorisation.value,
                      title: 'Motorisation',
                      hint: 'Choisir la motorisation',
                      items: motorisationList
                          .map<DropdownMenuItem<String>>((String val) =>
                              DropdownMenuItem<String>(
                                value: val,
                                child: Text(
                                  val,
                                  style: AppTextStyles.base.s13.w400.blackColor,
                                ),
                              ))
                          .toList(),
                      onChaged: (p0) => controller.onSelectMotorisation(p0),
                      textErr: controller.motorisationErr.isNotEmpty
                          ? controller.motorisationErr.value
                          : '',
                    ).paddingSymmetric(vertical: 10))
                : SizedBox.shrink(),
            controller.selectedType.value == 0
                ? Obx(() => CustomDropdownWidget(
                      value: controller.selectedOrigine.value,
                      title: 'Origine',
                      hint: 'Choisir l\'origine',
                      items: origineList
                          .map<DropdownMenuItem<String>>((String val) =>
                              DropdownMenuItem<String>(
                                value: val,
                                child: Text(
                                  val,
                                  style: AppTextStyles.base.s13.w400.blackColor,
                                ),
                              ))
                          .toList(),
                      onChaged: (p0) => controller.onSelectOrigine(p0),
                      textErr: controller.origineErr.isNotEmpty
                          ? controller.origineErr.value
                          : '',
                    ).paddingSymmetric(vertical: 10))
                : SizedBox.shrink(),
            controller.selectedType.value == 0
                ? Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: NameInput(
                              controller: controller.anneeModeleCtrl,
                              textInputType: TextInputType.number,
                              title: 'Année du modèle',
                              hint: '',
                            ).paddingSymmetric(vertical: 10),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: controller.selectedType.value == 0
                                ? NameInput(
                                    controller: controller.anneeCirculationCtrl,
                                    textInputType: TextInputType.number,
                                    title: 'Année circulation',
                                    hint: '',
                                  ).paddingSymmetric(vertical: 10)
                                : SizedBox.shrink(),
                          )
                        ],
                      ),
                      Obx(
                        () => controller.anneeModelErr.isEmpty
                            ? SizedBox.shrink()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  controller.anneeModelErr.value,
                                  style: AppTextStyles.base.s12.w400.redColor,
                                ).tr(),
                              ),
                      )
                    ],
                  )
                : SizedBox.shrink(),
            controller.selectedType.value == 0
                ? Obx(() => NameInput(
                      textInputType: TextInputType.number,
                      controller: controller.kilomtrageCtrl,
                      title: 'Kilométrage',
                      hint: '',
                      errorText: controller.kilometrageErr.isNotEmpty
                          ? controller.kilometrageErr.value
                          : null,
                    ).paddingSymmetric(vertical: 10))
                : SizedBox.shrink(),
            controller.selectedType.value != 5
                ? Obx(() => CustomDropdownWidget(
                      value: controller.selectedEtat.value,
                      title: 'État',
                      hint: 'Choisir l\'état',
                      items: etatList
                          .map<DropdownMenuItem<String>>((String val) =>
                              DropdownMenuItem<String>(
                                value: val,
                                child: Text(
                                  val.capitalizeFirst ?? val,
                                  style: AppTextStyles.base.s13.w400.blackColor,
                                ),
                              ))
                          .toList(),
                      onChaged: (p0) => controller.onSelectEtat(p0),
                      textErr: controller.etatErr.isNotEmpty
                          ? controller.etatErr.value
                          : '',
                    ).paddingSymmetric(vertical: 10))
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
