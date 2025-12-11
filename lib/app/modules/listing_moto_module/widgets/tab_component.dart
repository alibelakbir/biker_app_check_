import 'package:biker_app/app/modules/listing_moto_module/listing_moto_controller.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:biker_app/app/utils/widgets/bottom_tab_position.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabComponent extends GetWidget<ListingMotoController> {
  const TabComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomTabPosition(
      tabController: controller.tabController,
      tabs: List.generate(
        categoryList.length,
        (index) => SizedBox(
          width: 84,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            spacing: 8,
            children: [
              Obx(() => Image.asset(
                    '${ImageConstants.imagePath}/${categoryList[index]['imageName']!}',
                    color: controller.tabIndex.value == index
                        ? AppColors.kPrimaryColor
                        : AppColors.kPrimaryColor.withOpacity(0.6),
                    // width: 40,
                    height: 32,
                  )),
              Obx(() => Text(
                    categoryList[index]['name']!,
                    style: AppTextStyles.base.s11.w400.copyWith(
                      color: controller.tabIndex.value == index
                          ? AppColors.kPrimaryColor
                          : AppColors.black,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
