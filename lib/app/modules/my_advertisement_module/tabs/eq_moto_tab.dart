import 'package:biker_app/app/modules/my_advertisement_module/my_advertisement_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/annonce_item.dart';

class EqMotoTab extends GetWidget<MyAdvertisementController> {
  const EqMotoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.eqMotoResponse.value?.annonces == null ||
            controller.eqMotoResponse.value!.annonces.isEmpty
        ? SizedBox.shrink()
        : ListView.builder(
            itemCount: controller.eqMotoResponse.value!.annonces.length,
            itemBuilder: (BuildContext context, int index) {
              return AnnonceItem(
                ad: controller.eqMotoResponse.value!.annonces[index],
                onTapDisable: () => controller.disableAnnce(
                    controller.eqMotoResponse.value!.annonces[index].id),
              );
            },
          ));
  }
}
