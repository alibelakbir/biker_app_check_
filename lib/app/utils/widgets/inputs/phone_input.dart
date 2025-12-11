import 'package:biker_app/app/utils/image_constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../themes/app_text_theme.dart';
import '../../../utils/widgets/app_text_field/app_text_field.dart';

class PhoneInput extends StatelessWidget {
  final String title;
  final String hint;
  final String? errorText;
  final TextEditingController? controller;

  const PhoneInput({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.base.s12.w500.blackColor),
        const SizedBox(height: 4),
        AppTextField(
          controller: controller,
          hintText: hint,
          padding: EdgeInsets.zero,
          textInputType: TextInputType.numberWithOptions(decimal: false),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(9),
            FirstDigitOnlyFormatter(),
          ],
          errorText: errorText,
          darkDecoration: false,
          prefixWidget: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                ImageConstants.morocco,
              ).paddingAll(12),
              Text("+212", style: AppTextStyles.base.s13.w400.blackColor)
            ],
          ),
          prefixWidth: 84,
        ),
      ],
    );
  }
}

class FirstDigitOnlyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    if (text.isEmpty) return newValue;

    // Force first digit to be 6 or 7
    if (text.length == 1 &&
        !(text.startsWith('5') ||
            text.startsWith('6') ||
            text.startsWith('7'))) {
      return oldValue;
    }

    return newValue;
  }
}
