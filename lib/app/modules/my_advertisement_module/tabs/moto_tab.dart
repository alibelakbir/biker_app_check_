import 'package:biker_app/app/modules/my_advertisement_module/my_advertisement_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/annonce_item.dart';

class MotoTab extends GetWidget<MyAdvertisementController> {
  const MotoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.motoResponse.value?.annonces == null ||
            controller.motoResponse.value!.annonces.isEmpty
        ? SizedBox.shrink()
        : ListView.builder(
            itemCount: controller.motoResponse.value!.annonces.length,
            itemBuilder: (BuildContext context, int index) {
              return AnnonceItem(
                ad: controller.motoResponse.value!.annonces[index],
                onTapDisable: () => controller.disableAnnce(
                    controller.motoResponse.value!.annonces[index].id),
              );
            },
          ));
  }
}
