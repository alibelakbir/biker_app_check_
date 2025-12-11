import 'package:biker_app/app/modules/my_advertisement_module/my_advertisement_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/annonce_item.dart';

class EqPieceTab extends GetWidget<MyAdvertisementController> {
  const EqPieceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.pieceResponse.value?.annonces == null ||
            controller.pieceResponse.value!.annonces.isEmpty
        ? SizedBox.shrink()
        : ListView.builder(
            itemCount: controller.pieceResponse.value!.annonces.length,
            itemBuilder: (BuildContext context, int index) {
              return AnnonceItem(
                ad: controller.pieceResponse.value!.annonces[index],
                onTapDisable: () => controller.disableAnnce(
                    controller.pieceResponse.value!.annonces[index].id),
              );
            },
          ));
  }
}
