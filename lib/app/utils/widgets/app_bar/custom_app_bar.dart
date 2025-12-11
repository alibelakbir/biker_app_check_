import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../themes/app_colors.dart';
import '../../../themes/app_text_theme.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    Color? backgroundColor,
    double? elevation,
    Brightness? brightness,
    String? title,
    PreferredSizeWidget? preferredSizeWidget,
    super.leading,
    Widget? titleWidget,
    bool super.centerTitle = true,
    super.actions,
    TextStyle? titleStyle,
     Color? iconColor,
     SystemUiOverlayStyle ? systemUiOverlayStyle,
  }) : super(
          backgroundColor: backgroundColor ?? AppColors.kPrimaryColor,
          elevation: elevation ?? 0,
          title: titleWidget ??
              Text(
                title ?? '',
                style: titleStyle ?? AppTextStyles.base.s14.w700.whiteColor,
              ).tr(),
          automaticallyImplyLeading: titleWidget == null,
          iconTheme: IconThemeData(
            color: iconColor ?? AppColors.white,
            size: 18,
          ),
          bottom: preferredSizeWidget,
          systemOverlayStyle: systemUiOverlayStyle ?? SystemUiOverlayStyle(
              statusBarColor: backgroundColor ?? AppColors.kPrimaryColor,
              statusBarBrightness: brightness ?? Brightness.dark),
        );
}
