import 'package:biker_app/app/modules/listing_moto_module/listing_moto_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../widgets/moto_item.dart';

class MotoTab extends GetWidget<ListingMotoController> {
  const MotoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.motoResponse.value == null
        ? SizedBox.shrink()
        : SmartRefresher(
            key: Key('moto'),
            controller: controller.motoRefreshCntr,
            enablePullDown: false,
            enablePullUp: true,
            onLoading: () => controller.onLoadingMoto(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              shrinkWrap: true,
              itemCount: controller.motoResponse.value!.annonces.length,
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(height: 24),
              itemBuilder: (BuildContext context, int index) => MotoItem(
                moto: controller.motoResponse.value!.annonces[index],
              ),
            ),
          ));
  }
}
