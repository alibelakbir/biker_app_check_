import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../themes/app_text_theme.dart';
import '../../../utils/widgets/app_text_field/app_text_field.dart';

class NameInput extends StatelessWidget {
  final String title;
  final String hint;
  final String? errorText;
  final TextEditingController? controller;
  final bool darkDecoration;
  final VoidCallback? deleteAction;
  final bool enabled;
  final bool readOnly;
  final TextInputType? textInputType;
  final TextStyle? titleStyle;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  const NameInput(
      {super.key,
      required this.title,
      required this.hint,
      this.controller,
      this.errorText,
      this.darkDecoration = false,
      this.deleteAction,
      this.enabled = true,
      this.readOnly = false,
      this.textInputType,
      this.titleStyle,
      this.focusNode, this.textInputAction});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                    style: titleStyle ?? AppTextStyles.base.s12.w500.blackColor)
                .tr(),
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
          controller: controller,
          focusNode: focusNode,
          hintText: hint,
          padding: EdgeInsets.zero,
          textInputType: textInputType ?? TextInputType.text,
          errorText: errorText,
          darkDecoration: darkDecoration,
          enabled: enabled,
          readOnly: readOnly,
          maxLines: 1,
          textInputAction: textInputAction,
        ),
      ],
    );
  }
}
