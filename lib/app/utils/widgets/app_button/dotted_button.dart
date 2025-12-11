import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';
import '../../../themes/app_text_theme.dart';

class DottedButton extends StatelessWidget {
  final Function()? ontap;
  final String text;
  final double height;
  final double raduis;
  const DottedButton(
      {super.key,
      this.ontap,
      required this.text,
      this.height = 50,
      this.raduis = 12});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: AppColors.kPrimaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.all(Radius.circular(raduis)),
        ),
        child: DottedBorder(
          // padding: const EdgeInsets.all(15),
          color: AppColors.kPrimaryColor.withOpacity(0.2),
          radius: Radius.circular(raduis),
          dashPattern: const [8, 4],
          borderPadding: EdgeInsets.zero,
          borderType: BorderType.RRect,
          child: Center(
            child: Text(
              text,
              style: AppTextStyles.base.s13.w600.kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
