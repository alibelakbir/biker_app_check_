import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../themes/app_text_theme.dart';
import '../../../utils/widgets/app_text_field/app_text_field.dart';

class EmailInput extends StatelessWidget {
  final TextEditingController? controller;

  final String? errorText;
  final bool readOnly;
  final String? hint;
  final TextInputAction? textInputAction;

  const EmailInput({
    super.key,
    this.controller,
    this.errorText,
    this.readOnly = false,
    this.hint = "votre email",
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('email', style: AppTextStyles.base.s12.w500.blackColor).tr(),
        const SizedBox(height: 4),
        AppTextField(
          controller: controller,
          hintText: hint,
          padding: EdgeInsets.zero,
          textInputType: TextInputType.emailAddress,
          errorText: errorText,
          readOnly: readOnly,
          enabled: !readOnly,
          textInputAction: textInputAction ?? TextInputAction.next,
          darkDecoration: false,
        ),
      ],
    );
  }
}
