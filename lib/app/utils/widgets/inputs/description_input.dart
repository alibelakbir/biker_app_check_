import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../themes/app_text_theme.dart';
import '../app_text_field/app_text_field.dart';

class DescriptionInput extends StatelessWidget {
  final String title;
  final String hint;
  final String? errorText;
  final TextEditingController? controller;
  final bool darkDecoration;
  final VoidCallback? deleteAction;
  final TextInputAction? textInputAction;
  final TextStyle? titleStyle;
  const DescriptionInput(
      {super.key,
      required this.title,
      required this.hint,
      this.controller,
      this.errorText,
      this.darkDecoration = false,
      this.deleteAction,
      this.textInputAction,
      this.titleStyle});

  @override
  Widget build(BuildContext context) {
    final tStyle = titleStyle ?? AppTextStyles.base.s12.w500.blackColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: tStyle).tr(),
            deleteAction != null
                ? InkWell(
                    onTap: deleteAction,
                    child: Text(
                      'delete',
                      style: AppTextStyles.base.s14.w500.redColor,
                    ).tr())
                : const SizedBox()
          ],
        ),
        const SizedBox(height: 4),
        AppTextField(
          height: 118,
          maxLines: 6,
          controller: controller,
          hintText: hint,
          padding: EdgeInsets.zero,
          textInputType: TextInputType.text,
          errorText: errorText,
          darkDecoration: darkDecoration,
          contentPadding: const EdgeInsets.all(20),
          textInputAction: textInputAction,
        ),
      ],
    );
  }
}
