import 'package:biker_app/app/modules/listing_moto_module/widgets/eq_item.dart';
import 'package:biker_app/app/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:biker_app/app/modules/listing_moto_module/listing_moto_controller.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EquipementTab extends GetWidget<ListingMotoController> {
  const EquipementTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          controller.eqResponse.value == null
              ? SizedBox.shrink()
              : SmartRefresher(
                key: Key('eq-moto'),
                controller: controller.eqRefreshCntr,
                enablePullDown: false,
                enablePullUp: true,
                onLoading: () => controller.onLoadingEquipement(),
                child: GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: controller.eqResponse.value!.annonces.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.8, // width/height ratio
                  ),
                  itemBuilder:
                      (context, index) => EqItem(
                        eq: controller.eqResponse.value!.annonces[index],
                        category: Helpers.getCategoryByIndex(
                          controller.tabIndex.value,
                        ),
                      ),
                ),
              ),
    );
  }
}
