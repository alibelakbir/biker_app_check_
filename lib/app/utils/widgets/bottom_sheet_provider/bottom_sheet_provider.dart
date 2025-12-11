import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/widgets/app_divider/app_divider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetProvider {
  static showBottomSheet({
    Widget? content,
    String? title,
    double? maxHeight,
    EdgeInsets? padding,
    VoidCallback? callback,
    bool centerTitle = false,
  }) async {
    return await showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          height: maxHeight ?? 357,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                centerTitle
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
            children: [
              title == null
                  ? Align(
                    alignment: Alignment.center,
                    child: AppDefaultVertical(
                      height: 4,
                      width: 52,
                      color: AppColors.neutral3,
                      raduis: kRadius100,
                    ),
                  )
                  : Padding(
                    padding:
                        centerTitle
                            ? EdgeInsets.zero
                            : const EdgeInsets.only(left: 16),
                    child:
                        Text(
                          title,
                          style: AppTextStyles.base.s16.w600.blackColor,
                          textAlign:
                              centerTitle ? TextAlign.center : TextAlign.left,
                        ).tr(),
                  ),
              // const SizedBox(height: 16),
              Expanded(
                child: Padding(
                  padding: padding ?? EdgeInsets.zero,
                  child: content,
                ),
              ),
            ],
          ),
        );
      },
    ).whenComplete(callback ?? () {});
  }
}
