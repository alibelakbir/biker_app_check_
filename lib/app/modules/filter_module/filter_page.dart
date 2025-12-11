import 'package:biker_app/app/modules/filter_module/widgets/kilometrage_slider.dart';
import 'package:biker_app/app/modules/filter_module/widgets/model_input/model_input_widget.dart';
import 'package:biker_app/app/modules/filter_module/widgets/prix_slider%20copy.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/enums.dart';
import 'package:biker_app/app/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:biker_app/app/utils/widgets/app_button/app_button.dart';
import 'package:biker_app/app/utils/widgets/inputs/custom_dropdown_search.dart';
import 'package:biker_app/app/utils/widgets/inputs/custom_dropdown_widget.dart';
import 'package:biker_app/app/utils/widgets/inputs/name_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import '../../../app/modules/filter_module/filter_controller.dart';

class FilterPage extends GetWidget<FilterController> {
  const FilterPage({super.key});
  @override
  Widget build(BuildContext context) {
    //controller.onSetAutoSearch();
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Filter',
        titleStyle: AppTextStyles.base.s16.w600.blackColor,
        backgroundColor: AppColors.transparent,
        iconColor: AppColors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              controller.categoryIndex == 0
                  ? Obx(
                    () => CustomDropdownSearch(
                      bgColor: Color(0xFFF4F4F4),
                      value: controller.selectedBrand.value,
                      title: 'Marque',
                      hint: 'Choisr la marque',
                      titleStyle: AppTextStyles.base.s16.w600.blackColor,
                      items: [
                        'Toutes les marques'.toUpperCase(),
                        ...controller.brandList,
                      ],
                      onChaged: (p0) => controller.onSelectBrand(p0),
                    ).paddingSymmetric(vertical: 10),
                  )
                  : controller.categoryIndex == 3
                  ? SizedBox.shrink()
                  : Obx(
                    () => CustomDropdownWidget(
                      bgColor: Color(0xFFF4F4F4),
                      value: controller.selectedCategory.value,
                      title: 'Type équipement',
                      hint: ' Choisr type équipement',
                      titleStyle: AppTextStyles.base.s16.w600.blackColor,
                      items: [
                        DropdownMenuItem<String>(
                          value: '', // or 'default', null, etc.
                          child: Text(
                            'Toutes les équipement'.toUpperCase(),
                            style: AppTextStyles.base.s13.w400.blackColor,
                          ),
                        ),
                        ...controller.catList.map<DropdownMenuItem<String>>(
                          (String val) => DropdownMenuItem<String>(
                            value: val,
                            child: Text(
                              val,
                              style: AppTextStyles.base.s13.w400.blackColor,
                            ),
                          ),
                        ),
                      ],
                      onChaged: (p0) => controller.onSelectCategory(p0),
                    ).paddingSymmetric(vertical: 10),
                  ),
              controller.categoryIndex != 0
                  ? SizedBox.shrink()
                  : NameInput(
                    controller: controller.modeleCtrl,
                    focusNode: controller.modelNode,
                    title: 'Modèle',
                    hint: 'Modèle',
                    titleStyle: AppTextStyles.base.s16.w600.blackColor,
                    textInputAction: TextInputAction.done,
                  ).paddingSymmetric(vertical: 10),
              controller.categoryIndex != 0
                  ? SizedBox.shrink()
                  : Obx(
                    () => CustomDropdownWidget(
                      bgColor: Color(0xFFF4F4F4),
                      value: controller.cylendre.value,
                      title: 'Cylindrée',
                      hint: 'Choisir la cylindrée',
                      titleStyle: AppTextStyles.base.s16.w600.blackColor,
                      items: [
                        DropdownMenuItem<String>(
                          value: null, // or 'default', null, etc.
                          child: Text(
                            'Toutes cylindrée'.toUpperCase(),
                            style: AppTextStyles.base.s13.w400.blackColor,
                          ),
                        ),
                        ...CylindreEnum.values
                            .map<DropdownMenuItem<CylindreEnum>>(
                              (
                                CylindreEnum val,
                              ) => DropdownMenuItem<CylindreEnum>(
                                value: val,
                                child: Text(
                                  val.value,
                                  style: AppTextStyles.base.s13.w400.blackColor,
                                ),
                              ),
                            ),
                      ],
                      onChaged: (p0) => controller.onSelectCylindre(p0),
                    ),
                  ).paddingSymmetric(vertical: 10),
              controller.categoryIndex != 0
                  ? SizedBox.shrink()
                  : KilometrageSlider().paddingSymmetric(vertical: 10),
              prixSlider().paddingSymmetric(vertical: 10),
              Obx(
                () => CustomDropdownWidget(
                  value: controller.selectedCity.value,
                  title: 'Ville',
                  hint: 'Choisir votre ville',
                  titleStyle: AppTextStyles.base.s16.w600.blackColor,
                  items: [
                    DropdownMenuItem<String>(
                      value: '', // or 'default', null, etc.
                      child: Text(
                        'Toutes les villes'.toUpperCase(),
                        style: AppTextStyles.base.s13.w400.blackColor,
                      ),
                    ),
                    ...controller.cityList.map<DropdownMenuItem<String>>((
                      String val,
                    ) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(
                          val,
                          style: AppTextStyles.base.s13.w400.blackColor,
                        ),
                      );
                    }),
                  ],
                  onChaged: (p0) => controller.onSelectCity(p0),
                ).paddingSymmetric(vertical: 10),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: AppButton.outline(
                onPressed: controller.onResetFilter,
                text: 'Effacer les filtres',
              ),
            ),
            Expanded(
              child: AppButton(
                onPressed: controller.onApplyFilter,
                text: 'Recherche',
              ),
            ),
          ],
        ).paddingSymmetric(vertical: 20),
      ),
    );
  }
}
