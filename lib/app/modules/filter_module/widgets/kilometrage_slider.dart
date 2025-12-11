import 'package:biker_app/app/modules/filter_module/filter_controller.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class KilometrageSlider extends GetWidget<FilterController> {
  const KilometrageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Kilomètrage', style: AppTextStyles.base.s16.w600.blackColor),
        SizedBox(height: 4),
        Obx(() => Text(
            '${controller.kilometrageRange.value.start.round()} - ${controller.kilometrageRange.value.end == filterMaxKm ? 'Plus de ${filterMaxKm.round()}' : controller.kilometrageRange.value.end.round()} Km',
            style: AppTextStyles.base.s14.w400
                .copyWith(color: AppColors.black.withOpacity(0.5)))),
        SizedBox(height: 16),
        SliderTheme(
          data: SliderThemeData(
            overlayShape: SliderComponentShape.noOverlay,
            activeTrackColor: Colors.teal,
            inactiveTrackColor: Colors.amber,
            valueIndicatorColor:
                AppColors.kPrimaryColor, // Background color of the label bubble
            valueIndicatorTextStyle: AppTextStyles.base.s12.w600.whiteColor,
            showValueIndicator: ShowValueIndicator.onDrag,
            thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: 6, // Smaller thumb without border feel
              disabledThumbRadius: 0,
              elevation: 0,
              pressedElevation: 0,
            ),
          ),
          child: Obx(() => RangeSlider(
                values: controller.kilometrageRange.value,
                min: 0,
                max: filterMaxKm,
                divisions: 10,
                inactiveColor: const Color(0xFFE5E5E5),
                activeColor: AppColors.kPrimaryColor,
                onChanged: (RangeValues values) =>
                    controller.setkilometrageRange(values),
                labels: RangeLabels(
                  controller.kilometrageRange.value.start.round().toString(),
                  controller.kilometrageRange.value.end == filterMaxKm
                      ? 'Plus de ${filterMaxKm.round()}'
                      : controller.kilometrageRange.value.end
                          .round()
                          .toString(),
                ),
              )),
        ),
      ],
    );
  }
}
