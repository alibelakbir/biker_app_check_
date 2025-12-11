import 'package:biker_app/app/themes/app_colors.dart';
import 'package:flutter/material.dart';

class BackOvalWidget extends StatelessWidget {
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  const BackOvalWidget(
      {super.key, this.backgroundColor, this.iconColor, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        color: backgroundColor ?? AppColors.white,
        height: size,
        width: size,
        child: BackButton(
          style: ButtonStyle(
              iconSize: WidgetStatePropertyAll(size * 0.4),
              iconColor: WidgetStatePropertyAll(iconColor ?? AppColors.black)),
        ),
      ),
    );
  }
}
