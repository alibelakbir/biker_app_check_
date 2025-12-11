import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:flutter/material.dart';
import 'package:biker_app/app/themes/app_colors.dart';

class AppDivider extends Divider {
  const AppDivider({
    super.key,
    Color super.color = AppColors.colorDivider,
    double super.height = 1,
  }) : super(
          thickness: 1,
        );
}

class AppVerticalDivider extends StatelessWidget {
  const AppVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const VerticalDivider(
      color: AppColors.colorDivider,
      width: 1,
    );
  }
}

class AppDefaultVertical extends StatelessWidget {
  const AppDefaultVertical({
    super.key,
    this.height = 0,
    this.color = AppColors.colorDivider,
    this.width = 2,
    this.raduis = kRightRadius,
  });
  final double height;
  final Color color;
  final double width;
  final BorderRadiusGeometry? raduis;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: raduis,
      ),
    );
  }
}

class AppDefaultHorizontal extends StatelessWidget {
  const AppDefaultHorizontal({
    super.key,
    this.height = 0,
    this.color = AppColors.colorDivider,
  });
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: height,
      width: 1,
    );
  }
}

class AppDashDivider extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const AppDashDivider({
    super.key,
    this.height = 1,
    this.width = 10,
    this.color = AppColors.colorDivider,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = width;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
