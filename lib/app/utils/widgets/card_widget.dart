// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../themes/app_raduis.dart';

class CardWidget extends StatelessWidget {
  final Function()? ontap;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BoxDecoration? decoration;

  const CardWidget({
    super.key,
    this.ontap,
    required this.child,
    this.padding,
    this.constraints,
    this.margin,
    this.width,
    this.height,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin ?? EdgeInsets.zero,
        constraints: constraints,
        decoration: decoration ?? kLightCardDecoration,
        child: child,
      ),
    );
  }
}
