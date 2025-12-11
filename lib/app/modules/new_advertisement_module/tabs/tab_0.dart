import 'package:biker_app/app/modules/new_advertisement_module/new_advertisement_controller.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tab0 extends GetWidget<NewAdvertisementController> {
  const Tab0({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.fromLTRB(16, 40, 16,100),
      physics: ClampingScrollPhysics(),
      itemCount: categoryList.length, // example item count
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 items per row
        crossAxisSpacing: 20,
        mainAxisSpacing: 24,
        childAspectRatio: 1.5, // width/height ratio
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => controller.onSelectType(index),
          child: Obx(
            () => Container(
              decoration: BoxDecoration(
                  borderRadius: kRadius10,
                  border: Border.all(
                      width: 1,
                      color: index == controller.selectedType.value
                          ? AppColors.kSecondaryColor
                          : Color(0xFFDADADA))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12,
                children: [
                  Image.asset(
                    '${ImageConstants.imagePath}/${categoryList[index]['imageName']!}',
                    color: AppColors.kPrimaryColor,
                    //  width: 40,
                    height: 44,
                  ),
                  Text(
                    categoryList[index]['name']!,
                    style: AppTextStyles.base.s13.w500.blackColor,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
