import 'package:biker_app/app/modules/new_advertisement_module/new_advertisement_controller.dart';
import 'package:biker_app/app/utils/widgets/inputs/description_input.dart';
import 'package:biker_app/app/utils/widgets/inputs/name_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tab2 extends GetWidget<NewAdvertisementController> {
  const Tab2({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 40, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Obx(() => NameInput(
                  controller: controller.titreCtrl,
                  title: 'Titre',
                  hint: '',
                  errorText: controller.titreErr.isNotEmpty
                      ? controller.titreErr.value
                      : null,
                )),
            Obx(() => DescriptionInput(
                  controller: controller.descCtrl,
                  title: 'Description',
                  hint: '',
                  errorText: controller.descErr.isNotEmpty
                      ? controller.descErr.value
                      : null,
                )),
            Obx(() => NameInput(
                  textInputType: TextInputType.number,
                  controller: controller.prixCtrl,
                  title: 'Prix',
                  hint: '',
                  errorText: controller.prixErr.isNotEmpty
                      ? controller.prixErr.value
                      : null,
                )),
          ],
        ),
      ),
    );
  }
}
