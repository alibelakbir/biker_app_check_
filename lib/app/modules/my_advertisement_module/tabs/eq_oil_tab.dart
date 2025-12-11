import 'package:biker_app/app/modules/my_advertisement_module/my_advertisement_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/annonce_item.dart';

class EqOilTab extends GetWidget<MyAdvertisementController> {
  const EqOilTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.oilResponse.value?.annonces == null ||
            controller.oilResponse.value!.annonces.isEmpty
        ? SizedBox.shrink()
        : ListView.builder(
            itemCount: controller.oilResponse.value!.annonces.length,
            itemBuilder: (BuildContext context, int index) {
              return AnnonceItem(
                ad: controller.oilResponse.value!.annonces[index],
                onTapDisable: () => controller.disableAnnce(
                    controller.oilResponse.value!.annonces[index].id),
              );
            },
          ));
  }
}
