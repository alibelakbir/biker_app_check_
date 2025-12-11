import 'package:biker_app/app/modules/my_advertisement_module/my_advertisement_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/annonce_item.dart';

class EqPneuTab extends GetWidget<MyAdvertisementController> {
  const EqPneuTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.pneuResponse.value?.annonces == null ||
            controller.pneuResponse.value!.annonces.isEmpty
        ? SizedBox.shrink()
        : ListView.builder(
            itemCount: controller.pneuResponse.value!.annonces.length,
            itemBuilder: (BuildContext context, int index) {
              return AnnonceItem(
                ad: controller.pneuResponse.value!.annonces[index],
                onTapDisable: () => controller.disableAnnce(
                    controller.pneuResponse.value!.annonces[index].id),
              );
            },
          ));
  }
}
