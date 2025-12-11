import 'package:easy_localization/easy_localization.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_raduis.dart';
import '../../../themes/app_text_theme.dart';
import 'package:flutter/material.dart';

class CustomDropdownWidget extends StatelessWidget {
  final String title;
  final String hint;
  final List<DropdownMenuItem<dynamic>>? items;
  final dynamic value;
  final Function(dynamic)? onChaged;
  final String textErr;
  final Color? bgColor;
  final TextStyle? titleStyle;
  final double? height;

  const CustomDropdownWidget(
      {super.key,
      required this.title,
      required this.hint,
      required this.items,
      this.value,
      this.onChaged,
      this.textErr = '',
      this.bgColor,
      this.titleStyle,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
                style: titleStyle ??
                    AppTextStyles.base.s12.w500
                        .copyWith(color: AppColors.black))
            .tr(),
        const SizedBox(height: 4),
        Container(
          height: height ?? 48,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: dropDownDecoration,
          child: DropdownButton<dynamic>(
              value: value,
              elevation: 0,
              style: AppTextStyles.base.s13.w400.whiteColor,
              isExpanded: true,
              borderRadius: kRadius8,
              dropdownColor: bgColor ?? AppColors.white,
              focusColor: AppColors.neutral6,
              underline: const SizedBox(),
              iconEnabledColor: AppColors.white,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.black,
              ),
              hint: Text(hint, style: AppTextStyles.base.s13.w400.neutral3Color)
                  .tr(),
              items: items,
              onChanged: onChaged),
        ),
        if (textErr.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4).copyWith(top: 4),
            child: Text(
              textErr,
              style: AppTextStyles.base.s12.w400.redColor,
            ).tr(),
          ),
      ],
    );
  }
}
