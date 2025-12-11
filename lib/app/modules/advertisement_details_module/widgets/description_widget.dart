import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class DescriptionWidget extends StatelessWidget {
  final String desc;

  const DescriptionWidget({super.key, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text(
          'Description',
          style: AppTextStyles.base.s16.w700.blackColor,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        ReadMoreText(
          desc,
          trimLines: 3,
          style: AppTextStyles.base.s14.w400.copyWith(
            height: 1.2,
            color: Color(0xFF939393),
          ),
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Voir plus...',
          trimExpandedText: ' Voir moins',
          delimiter: ' ',
          moreStyle: AppTextStyles.base.s12.w500.kPrimaryColor.copyWith(
            height: 2,
            // decoration: TextDecoration.underline,
          ),
          lessStyle: AppTextStyles.base.s12.w500.kPrimaryColor.copyWith(
            height: 2,
            //decoration: TextDecoration.underline,
          ),
        ),
      ],
    ).paddingAll(16);
  }
}
