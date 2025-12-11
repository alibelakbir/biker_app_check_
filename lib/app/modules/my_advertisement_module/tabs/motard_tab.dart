import 'package:biker_app/app/modules/my_advertisement_module/my_advertisement_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/annonce_item.dart';

class MotardTab extends GetWidget<MyAdvertisementController> {
  const MotardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.eqMotardResponse.value?.annonces == null ||
            controller.eqMotardResponse.value!.annonces.isEmpty
        ? SizedBox.shrink()
        : ListView.builder(
            itemCount: controller.eqMotardResponse.value!.annonces.length,
            itemBuilder: (BuildContext context, int index) {
              return AnnonceItem(
                ad: controller.eqMotardResponse.value!.annonces[index],
                onTapDisable: () => controller.disableAnnce(
                    controller.eqMotardResponse.value!.annonces[index].id),
              );
            },
          ));
  }
}
