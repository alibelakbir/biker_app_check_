import 'dart:io';

import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/back_oval_widget.dart';
import 'package:biker_app/app/utils/local_data.dart';
import 'package:biker_app/app/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:biker_app/app/utils/widgets/app_button/app_button.dart';
import 'package:biker_app/app/utils/widgets/cached_image.dart';
import 'package:biker_app/app/utils/widgets/inputs/custom_dropdown_widget.dart';
import 'package:biker_app/app/utils/widgets/inputs/description_input.dart';
import 'package:biker_app/app/utils/widgets/inputs/email_input.dart';
import 'package:biker_app/app/utils/widgets/inputs/name_input.dart';
import 'package:biker_app/app/utils/widgets/inputs/phone_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../app/modules/my_profile_module/my_profile_controller.dart';

class EditProfilePage extends GetWidget<MyProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: AppColors.white,
        brightness: Brightness.light,
        titleWidget: Row(
          children: [BackOvalWidget(backgroundColor: Color(0xFFECECEC))],
        ),
        preferredSizeWidget: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Row(
            children: [
              Text(
                'Editer',
                textAlign: TextAlign.left,
                style: AppTextStyles.base.s32.w600.blackColor,
              ).paddingSymmetric(horizontal: 16),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0).copyWith(
            top: controller.pController.appUser?.role == 'boutique' ? 24 : 32,
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              controller.pController.appUser?.role == 'boutique'
                  ? Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => controller.pickMedia(),
                        child: Obx(
                          () =>
                              controller.logo.isNotEmpty
                                  ? Container(
                                    width: 74,
                                    height: 74,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.neutral6,
                                      border: Border.all(
                                        width: 2,
                                        color: AppColors.kPrimaryColor,
                                      ),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            controller.logo.value.contains(
                                                  'http',
                                                )
                                                ? NetworkImage(
                                                  controller.logo.value,
                                                )
                                                : FileImage(
                                                  File(controller.logo.value),
                                                ),
                                      ),
                                    ),
                                  )
                                  : Container(
                                    width: 74,
                                    height: 74,
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.neutral6,
                                      border: Border.all(
                                        width: 2,
                                        color: AppColors.kPrimaryColor,
                                      ),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/icon/boutique.svg',
                                      ),
                                    ),
                                  ),
                        ),
                      ),
                      AppButton.outline(
                        height: 38,
                        width: 120,
                        onPressed: () => controller.pickMedia(),
                        text: 'Modifier logo',
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        style: AppTextStyles.base.w600.s12.whiteColor,
                      ),
                    ],
                  )
                  : SizedBox.shrink(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  Expanded(
                    child: Obx(
                      () => NameInput(
                        controller: controller.fNameCtrl,
                        title: 'Prénom',
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
                        title: 'Nom',
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
                () => NameInput(
                  controller: controller.companyNameCtrl,
                  title: 'Nom d\'entreprise',
                  hint: 'Votre nom d\'entreprise',
                  errorText:
                      controller.companyNameErr.isNotEmpty
                          ? controller.companyNameErr.value
                          : null,
                ),
              ),
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
                () => NameInput(
                  controller: controller.addressCtrl,
                  title: 'Adresse',
                  hint: 'Votre adresse',
                  errorText:
                      controller.addressErr.isNotEmpty
                          ? controller.addressErr.value
                          : null,
                ),
              ),
              Obx(
                () => DescriptionInput(
                  controller: controller.descCtrl,
                  title: 'Description',
                  hint: 'Votre description',
                  errorText:
                      controller.descErr.isNotEmpty
                          ? controller.descErr.value
                          : null,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 70,
          padding: EdgeInsets.only(bottom: 16),
          decoration: kLightCardDecoration.copyWith(
            borderRadius: BorderRadius.zero,
          ),
          child: Center(
            child: AppButton(
              onPressed: () => controller.updateUser(),
              text: 'Modifier',
            ),
          ),
        ),
      ),
    );
  }
}
