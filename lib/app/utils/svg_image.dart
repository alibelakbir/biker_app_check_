import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImage extends StatelessWidget {
  final String assetName;
  final Color? color;
    final double? height;
  final double? width;
  const SvgImage(this.assetName, {super.key, this.color, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(assetName,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        height: height,
        width: width,
        excludeFromSemantics: true);
  }
}
