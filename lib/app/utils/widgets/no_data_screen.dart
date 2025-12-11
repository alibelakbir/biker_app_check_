import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../themes/app_text_theme.dart';

class NoDataScreen extends StatelessWidget {
  final String? text;
  final double? height;
  const NoDataScreen({super.key, this.text, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? Get.height * 0.3,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset('assets/icon/empty-data.svg'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Text(
              text ?? 'No data available.',
              style: AppTextStyles.base.s12.w500.grayColor
                  .copyWith(height: 1.4, letterSpacing: 0.8),
              textAlign: TextAlign.center,
            ),
          ]),
    );
  }
}
