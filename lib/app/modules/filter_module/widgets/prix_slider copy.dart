import 'package:biker_app/app/modules/filter_module/filter_controller.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class prixSlider extends GetWidget<FilterController> {
  const prixSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Prix', style: AppTextStyles.base.s16.w600.blackColor),
        SizedBox(height: 4),
        Obx(() => Text(
            '${controller.priceRange.value.start.round()} - ${controller.priceRange.value.end == filterMaxPrice ? 'Plus de ${filterMaxPrice.round()}' : controller.priceRange.value.end.round().toString()} DH',
            style: AppTextStyles.base.s14.w400
                .copyWith(color: AppColors.black.withOpacity(0.5)))),
        SizedBox(height: 16),
        SliderTheme(
          data: SliderThemeData(
            overlayShape: SliderComponentShape.noOverlay,
            valueIndicatorColor:
                AppColors.kPrimaryColor, // Background color of the label bubble
            valueIndicatorTextStyle: AppTextStyles.base.s12.w600.whiteColor,
            showValueIndicator: ShowValueIndicator.onDrag,
            activeTrackColor: Colors.teal,
            inactiveTrackColor: Colors.amber,
            /*  thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: 6, // Smaller thumb without border feel
              disabledThumbRadius: 0,
              elevation: 0,
              pressedElevation: 0,
            ), */
          ),
          child: Obx(() => RangeSlider(
                values: controller.priceRange.value,
                min: 0,
                max: filterMaxPrice,
                divisions: 20,
                inactiveColor: const Color(0xFFE5E5E5),
                activeColor: AppColors.kPrimaryColor,
                labels: RangeLabels(
                  controller.priceRange.value.start.round().toString(),
                  controller.priceRange.value.end == filterMaxPrice
                      ? 'Plus de ${filterMaxPrice.round()}'
                      : controller.priceRange.value.end.round().toString(),
                ),
                onChanged: (RangeValues values) =>
                    controller.setPriceRange(values),
              )),
        ),
      ],
    );
  }
}
