import 'package:biker_app/app/modules/new_advertisement_module/new_advertisement_controller.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/widgets/app_button/dotted_button.dart';
import 'package:biker_app/app/utils/widgets/file_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tab3 extends GetWidget<NewAdvertisementController> {
  const Tab3({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 20, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.gray,
                  size: 16,
                ),
                Expanded(
                  child: Text(
                    " La taille maximale de la photo est de 8 Mo.\nFormats : jpeg, jpg, png.\nMettez la photo principale en premier",
                    style: AppTextStyles.base.s13.w400.grayColor,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*   InkWell(
                  onTap: () => controller.pickMedia(),
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor.withOpacity(0.05),
                        borderRadius: kRadius12),
                    child: DottedBorder(
                      // padding: const EdgeInsets.all(15),
                      color: AppColors.kPrimaryColor.withOpacity(0.2),
                      radius: const Radius.circular(12),
                      dashPattern: const [8, 4],
                      borderPadding: EdgeInsets.zero,
                      borderType: BorderType.RRect,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 8,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              color: AppColors.kPrimaryColor,
                              size: 18,
                            ),
                            Text(
                              'Ajouter des photos ',
                              style: AppTextStyles.base.s12.w600.kPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                */
                Obx(() => controller.mediaErr.isNotEmpty
                    ? Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 4).copyWith(
                          top: 4,
                        ),
                        child: Text(
                          controller.mediaErr.value,
                          style: AppTextStyles.base.s12.w400.redColor,
                        ),
                      )
                    : SizedBox.shrink()),
              ],
            ),
            Obx(() => controller.medias.isNotEmpty
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                    ),
                    itemCount: controller.medias.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return controller.medias[index].isEmpty
                          ? DottedButton(
                              text: 'Choisir une photo',
                              ontap: () => controller.pickMedia(index),
                            )
                          : FileWidget(
                              filePath: controller.medias[index],
                              onDelete: () => controller.removeMedia(index),
                              isPrimary: index == 0,
                            );
                    },
                  )
                : SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
