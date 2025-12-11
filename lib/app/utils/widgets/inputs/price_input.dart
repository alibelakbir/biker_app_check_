import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../themes/app_text_theme.dart';
import '../../../utils/widgets/app_text_field/app_text_field.dart';

class PriceInput extends StatelessWidget {
  final String? title;
  final String? hint;
  final String? errorText;
  final TextEditingController? controller;
  final bool darkDecoration;
  final VoidCallback? deleteAction;
  const PriceInput(
      {super.key,
      this.title,
      this.hint,
      this.controller,
      this.errorText,
      this.darkDecoration = true,
      this.deleteAction});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title ?? 'ticket_price',
              style: AppTextStyles.base.s12.w500.copyWith(
                color: Color(0xFF6C7278),
              ),
            ).tr(),
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
          hintText: hint ?? '150',
          padding: EdgeInsets.zero,
          textInputType: TextInputType.number,
          errorText: errorText,
          darkDecoration: darkDecoration,
        ),
      ],
    );
  }
}
