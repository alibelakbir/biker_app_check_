import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';
import '../../../themes/app_text_theme.dart';
import 'base_button.dart';

class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    required this.onPressed,
    this.text,
    this.color = AppColors.kPrimaryColor,
    this.style,
    this.prefixIcon,
    this.suffixIcon,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    this.margin = const EdgeInsets.symmetric(horizontal: 16),
    this.space = 12,
    this.height = 48,
    this.width = double.infinity,
    this.borderRadius,
    this.borderWidth = 1.0,
    this.backgroundColor,
    this.isLoading = false,
    this.shadow,
  }) {
    isOutline = false;
  }

  AppButton.outline({
    super.key,
    required this.onPressed,
    this.text,
    this.color = AppColors.kPrimaryColor,
    this.style,
    this.prefixIcon,
    this.suffixIcon,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.margin = const EdgeInsets.symmetric(horizontal: 16),
    this.space = 12,
    this.height = 47,
    this.width = double.infinity,
    this.borderRadius,
    this.borderWidth = 1.0,
    this.backgroundColor,
    this.isLoading = false,
    this.shadow,
  }) {
    isOutline = true;
  }

  late final bool isOutline;
  final String? text;
  final VoidCallback? onPressed;
  final Color color;
  final TextStyle? style;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double space;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final double borderWidth;
  final Color? backgroundColor;
  final bool isLoading;
  final List<BoxShadow>? shadow;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = style ?? AppTextStyles.base.w600.s14.whiteColor;
    return Padding(
      padding: margin,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        child: BaseButton(
          onPressed: onPressed,
          color:
              isOutline
                  ? backgroundColor ?? AppColors.kPrimaryColor.withOpacity(0.05)
                  : color,
          child: Container(
            height: height,
            width: width,
            padding: padding,
            decoration: BoxDecoration(
              border:
                  onPressed != null
                      ? Border.all(
                        color: color.withOpacity(0.2),
                        width: borderWidth,
                      )
                      : null,
              borderRadius: borderRadius ?? BorderRadius.circular(12),
              boxShadow: shadow,
            ),
            child:
                isLoading
                    ? const Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      ),
                    )
                    : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (prefixIcon != null)
                          prefixIcon != null && text == null
                              ? Expanded(child: Center(child: prefixIcon!))
                              : Padding(
                                padding: EdgeInsets.only(
                                  right: text == null ? 0 : space,
                                ),
                                child: prefixIcon!,
                              ),
                        if (text != null)
                          Expanded(
                            child: Center(
                              child:
                                  Text(
                                    text ?? "",
                                    style:
                                        isOutline
                                            ? textStyle.copyWith(color: color)
                                            : textStyle,
                                  ).tr(),
                            ),
                          ),
                        if (suffixIcon != null)
                          Padding(
                            padding: EdgeInsets.only(
                              right: text == null ? 0 : space,
                            ),
                            child: suffixIcon!,
                          ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
