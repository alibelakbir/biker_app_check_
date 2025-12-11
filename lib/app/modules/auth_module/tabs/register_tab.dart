import 'package:biker_app/app/modules/auth_module/auth_controller.dart';
import 'package:biker_app/app/modules/auth_module/widgets/cgu_widget.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/widgets/inputs/custom_dropdown_widget.dart';
import 'package:biker_app/app/utils/widgets/inputs/email_input.dart';
import 'package:biker_app/app/utils/widgets/inputs/name_input.dart';
import 'package:biker_app/app/utils/widgets/inputs/password_input.dart';
import 'package:biker_app/app/utils/widgets/inputs/phone_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterTab extends GetWidget<AuthController> {
  const RegisterTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Expanded(
              child: Obx(
                () => NameInput(
                  controller: controller.fNameCtrl,
                  title: 'first_name',
                  hint: 'Votre prénom',
                  errorText:
                      controller.fNameErr.isNotEmpty
                          ? controller.fNameErr.value
                          : null,
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => NameInput(
                  controller: controller.lNameCtrl,
                  title: 'last_name',
                  hint: 'Votre nom',
                  errorText:
                      controller.lNameErr.isNotEmpty
                          ? controller.lNameErr.value
                          : null,
                ),
              ),
            ),
          ],
        ),
        Obx(
          () => CustomDropdownWidget(
            value: controller.selectedCity.value,
            title: 'city',
            hint: 'choose_city',
            items:
                controller.cityList.map<DropdownMenuItem<String>>((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(
                      val,
                      style: AppTextStyles.base.s13.w400.blackColor,
                    ),
                  );
                }).toList(),
            onChaged: (p0) => controller.onSelectCity(p0),
          ),
        ),
        Obx(
          () => EmailInput(
            controller: controller.emailCtrl,
            errorText:
                controller.emailErr.isNotEmpty
                    ? controller.emailErr.value
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
        Obx(
          () => PasswordInput(
            controller: controller.passCtrl,
            errorText:
                controller.passErr.isNotEmpty ? controller.passErr.value : null,
          ),
        ),
        PasswordInput(
          controller: controller.confirmPassCtrl,
          title: 'Confirmation du mot de passe',
          errorText:
              controller.confirmPassErr.isNotEmpty
                  ? controller.confirmPassErr.value
                  : null,
        ),
        CguWidget(),
        SizedBox(height: kBottomNavigationBarHeight + 40),
      ],
    );
  }
}
