
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryComponent extends StatelessWidget {
  const CategoryComponent({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          categoryList.length,
          (index) => GestureDetector(
            onTap: () =>
                Get.toNamed(AppRoutes.listingMoto, arguments: {"index": index}),
            child: Container(
              width: 100,
              padding: EdgeInsets.only(bottom: 12, left: 8, right: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  Image.asset(
                    '${ImageConstants.imagePath}/${categoryList[index]['imageName']!}',
                    color: AppColors.white,
                    //  width: 40,
                    height: 32,
                  ),
                  Text(
                    categoryList[index]['name']!,
                    style: AppTextStyles.base.s11.w400.whiteColor,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
