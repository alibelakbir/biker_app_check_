import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../themes/app_text_theme.dart';
import '../../../utils/widgets/app_text_field/app_text_field.dart';


class PasswordInput extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String? errorText;
  final bool darkDecoration;

  const PasswordInput(
      {super.key,
      this.title = "password",
      this.controller,
      this.errorText,
      this.darkDecoration = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.base.s12.w500.copyWith(
            color: Color(0xFF6C7278),
          ),
        ).tr(),
        const SizedBox(height: 4),
        AppTextField(
          controller: controller,
          hintText: "••••••••••••••••••••",
          padding: EdgeInsets.zero,
          obscureText: true,
          maxLines: 1,
          errorText: errorText,
          darkDecoration: darkDecoration,
        ),
      ],
    );
  }
}
