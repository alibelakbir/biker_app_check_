// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: library_private_types_in_public_api

import 'package:biker_app/app/themes/app_decoration.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';
import '../../../themes/app_text_theme.dart';

class AppTextSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onTapSearchIcon;
  final Function(String) onTapSubmitted;
  final Color? textColor;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool darkDecoration;

  const AppTextSearchField({
    super.key,
    this.controller,
    this.onTapSearchIcon,
    required this.onTapSubmitted,
    this.hintText,
    this.errorText,
    this.color = AppColors.white,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.enableSuffixIcon = true,
    this.textColor,
    this.suffixIcon,
    this.focusNode,
    this.darkDecoration = false,
  });
  final String? hintText;
  final String? errorText;
  final Color? color;
  final EdgeInsetsGeometry padding;
  final bool enableSuffixIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 44,
            decoration: BoxDecoration(
                color: color,
                borderRadius: kRadius20,
                boxShadow: [AppDecoration.searchShadow]),
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              style: AppTextStyles.base.s13.w400
                  .copyWith(color: textColor ?? AppColors.white),
              textInputAction: TextInputAction.search,
              //cursorColor: AppColors.black,
              enableInteractiveSelection: false,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: InputBorder.none,
                /* enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: const Color(0xFFE6E2EA)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: AppColors.kPrimaryColor),
                ), */
                hintText: hintText,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintStyle: AppTextStyles.base.s14.w600.grayColor,
                suffixIcon: suffixIcon,
                suffixIconConstraints: const BoxConstraints(maxHeight: 48),
                prefixIcon: InkWell(
                  onTap: onTapSearchIcon,
                  child: const Padding(
                      padding: EdgeInsets.only(left: 16, right: 32),
                      child: Icon(
                        Icons.search,
                        color: Color(0xFF3C2F2F),
                      )),
                ),
                prefixIconConstraints: const BoxConstraints(
                  maxWidth: 40,
                ),
              ),
              onSubmitted: (value) => onTapSubmitted(value),
            ),
          ),
          if (errorText != null && errorText!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
                top: 4,
              ),
              child: Text(
                errorText ?? 'noEmpty',
                style: AppTextStyles.base.s14.redColor,
              ).tr(),
            ),
        ],
      ),
    );
  }
}
