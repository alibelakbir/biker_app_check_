// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../themes/app_colors.dart';
import '../../../themes/app_raduis.dart';
import '../../../themes/app_text_theme.dart';
import 'package:flutter/cupertino.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.errorText,
    this.prefixWidget,
    this.maxLines,
    this.suffixWidget,
    this.height = 48,
    this.borderRadius = kRadius8,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.textInputType = TextInputType.text,
    this.enabled,
    this.readOnly = false,
    this.color = const Color(0xFF1E1843),
    this.textInputAction = TextInputAction.next,
    this.obscureText,
    this.darkDecoration = true,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.focusNode,
    this.suffixWidth,
    this.prefixWidth,
    this.inputFormatters,
  });
  final TextEditingController? controller;
  final String? hintText;
  final String? errorText;
  final Widget? prefixWidget;
  final int? maxLines;
  final Widget? suffixWidget;
  final double height;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry padding;
  final TextInputType textInputType;
  final bool? enabled;
  final bool readOnly;
  final Color color;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final bool darkDecoration;
  final EdgeInsetsGeometry contentPadding;
  final FocusNode? focusNode;
  final double? suffixWidth;
  final double? prefixWidth;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final RxBool _obscureText = false.obs;
  @override
  void initState() {
    super.initState();
    _obscureText.value = widget.obscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.darkDecoration ? widget.color : AppColors.white,
              borderRadius: widget.borderRadius,
            ),
            child: Obx(() {
              return TextField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                obscureText: _obscureText.value,
                maxLines: widget.maxLines,
                keyboardType: widget.textInputType,
                enabled: widget.enabled,
                readOnly: widget.readOnly,
                textInputAction: widget.textInputAction,
                inputFormatters: widget.inputFormatters,
                style: AppTextStyles.base.s13.w400.copyWith(
                  color:
                      widget.darkDecoration ? AppColors.white : AppColors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color:
                          widget.darkDecoration
                              ? const Color(0xFF433A78)
                              : const Color(0xFFE6E2EA),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                  hintText: widget.hintText,
                  contentPadding: widget.contentPadding,
                  hintStyle: AppTextStyles.base.s13.w400.neutral3Color,
                  suffixIcon:
                      widget.obscureText != null
                          ? InkWell(
                            onTap:
                                () => _obscureText.value = !_obscureText.value,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 42),
                              child:
                                  _obscureText.value
                                      ? const Icon(
                                        CupertinoIcons.eye_slash,
                                        color: Color(0xFFB5AEE0),
                                        size: 20,
                                      )
                                      : const Icon(
                                        CupertinoIcons.eye,
                                        color: Color(0xFFB5AEE0),
                                        size: 20,
                                      ),
                            ),
                          )
                          : widget.suffixWidget ?? const SizedBox.shrink(),
                  suffixIconConstraints: BoxConstraints(
                    maxWidth: widget.suffixWidth ?? 42,
                  ),
                  prefixIcon: widget.prefixWidget ?? const SizedBox(width: 16),
                  prefixIconConstraints: BoxConstraints(
                    maxWidth: widget.prefixWidth ?? 16,
                  ),
                ),
              );
            }),
          ),
          if (widget.errorText != null && widget.errorText!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
              ).copyWith(top: 4),
              child:
                  Text(
                    widget.errorText ?? 'noEmpty',
                    style: AppTextStyles.base.s12.w400.redColor,
                  ).tr(),
            ),
        ],
      ),
    );
  }
}
