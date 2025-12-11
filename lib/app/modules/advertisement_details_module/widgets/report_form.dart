import 'package:biker_app/app/modules/advertisement_details_module/report_controller.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/widgets/app_button/app_button.dart';
import 'package:biker_app/app/utils/widgets/inputs/custom_dropdown_widget.dart';
import 'package:biker_app/app/utils/widgets/inputs/description_input.dart';
import 'package:biker_app/app/utils/widgets/inputs/email_input.dart';
import 'package:biker_app/app/utils/widgets/inputs/phone_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportForm extends GetWidget<ReportController> {
  const ReportForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    spacing: 16,
                    children: [
                      Obx(() => CustomDropdownWidget(
                            height: 64,
                            title: 'Motif*',
                            hint: 'Sélectionner un motif',
                            value: controller.selectedReportMotif.value,
                            items: reportMotifList
                                .map<DropdownMenuItem<Map<String, dynamic>>>(
                                    (Map<String, dynamic> val) {
                              return DropdownMenuItem<Map<String, dynamic>>(
                                value: val,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  spacing: 4,
                                  children: [
                                    Text(
                                      val["title"],
                                      style:
                                          AppTextStyles.base.s13.w400.blackColor,
                                    ),
                                    Text(
                                      val["description"],
                                      style:
                                          AppTextStyles.base.s10.w400.grayColor,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChaged: (p0) => controller.onChangeReportMotif(p0),
                            textErr: controller.motifErr.value,
                          )),
                      DescriptionInput(
                          controller: controller.descCtrl,
                          title: 'Détails',
                          hint: 'Précisions utiles (facultatif)'),
                      EmailInput(
                        controller: controller.emailCtrl,
                      ),
                      PhoneInput(
                          controller: controller.phoneCtrl,
                          title: 'Téléphone (facultatif)',
                          hint: '661xxxx0011'),
                      const Spacer(),
                      Row(
                        spacing: 16,
                        children: [
                          Expanded(
                            child: AppButton.outline(
                              height: 48,
                              onPressed: () => Get.back(),
                              text: 'Annuler',
                              margin: EdgeInsets.zero,
                            ),
                          ),
                          Expanded(
                            child: AppButton(
                              onPressed: () {
                                controller.report();
                              },
                              text: 'Envoyer',
                              margin: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
