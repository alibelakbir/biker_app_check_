import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:flutter/material.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;
  final Function() onDelete;
  const FilterChipWidget(
      {super.key, required this.label, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration:
          BoxDecoration(color: Color(0xFFF3F5F7), borderRadius: kRadius6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 32,
        children: [
          Text(
            label,
            style: AppTextStyles.base.s10.w400.blackColor,
          ),
          GestureDetector(
            onTap: onDelete,
            child: Icon(
              Icons.close_outlined,
              color: AppColors.black,
              size: 15,
            ),
          )
        ],
      ),
    );
  }
}
