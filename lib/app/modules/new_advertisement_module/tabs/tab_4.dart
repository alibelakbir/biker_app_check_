import 'package:biker_app/app/modules/new_advertisement_module/new_advertisement_controller.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/widgets/inputs/custom_dropdown_widget.dart';
import 'package:biker_app/app/utils/widgets/inputs/name_input.dart';
import 'package:biker_app/app/utils/widgets/inputs/phone_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tab4 extends GetWidget<NewAdvertisementController> {
  const Tab4({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 40, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Obx(
              () => CustomDropdownWidget(
                value: controller.selectedCity.value,
                title: 'Ville',
                hint: 'Choisir votre ville',
                items:
                    controller.cityList.map<DropdownMenuItem<String>>((
                      String val,
                    ) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(
                          val,
                          style: AppTextStyles.base.s13.w400.blackColor,
                        ),
                      );
                    }).toList(),
                onChaged: (p0) => controller.onSelectCity(p0),
                textErr:
                    controller.cityErr.isNotEmpty
                        ? controller.cityErr.value
                        : '',
              ),
            ),
            Obx(
              () => NameInput(
                controller: controller.sellerNameCtrl,
                title: 'Nom du Vendeur',
                hint: 'Votre nom',
                errorText:
                    controller.sellerNameErr.isNotEmpty
                        ? controller.sellerNameErr.value
                        : null,
              ),
            ),
            Obx(
              () => PhoneInput(
                controller: controller.phoneCtrl,
                title: 'Numéro de téléphone',
                hint: '652 xxx xxx',
                errorText:
                    controller.phoneErr.isNotEmpty
                        ? controller.phoneErr.value
                        : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
