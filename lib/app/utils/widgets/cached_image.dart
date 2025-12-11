// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../themes/app_colors.dart';

class CachedImage extends StatelessWidget {
  final String? imageUrl;
  final double height;
  final double width;
  final BorderRadiusGeometry? borderRadius;
  final BoxShape shape;
  final bool enableBorder;
  final bool darkBorder;
  final double borderSize;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;
  final int? progress;
  final Color progressColor;
  final Widget? companyImage;
  final BoxFit? fit;

  const CachedImage(
      {super.key,
      this.imageUrl,
      this.height = double.maxFinite,
      this.width = double.maxFinite,
      this.borderRadius,
      this.shape = BoxShape.rectangle,
      this.enableBorder = false,
      this.darkBorder = false,
      this.borderSize = 1.5,
      this.borderColor,
      this.boxShadow,
      this.progress,
      this.progressColor = AppColors.kPrimaryColor,
      this.companyImage,
      this.fit});

  @override
  Widget build(BuildContext context) {
    return imageUrl != null && imageUrl!.isNotEmpty
        ? CachedNetworkImage(
            imageUrl: imageUrl!,
            errorListener: (value) {},
            imageBuilder: (context, imageProvider) => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                boxShadow: boxShadow,
                border: enableBorder && progress == null
                    ? Border.all(
                        color: borderColor != null
                            ? borderColor!
                            : darkBorder
                                ? const Color(0xFF2D2D49)
                                : AppColors.white,
                        width: borderSize)
                    : null,
                borderRadius: borderRadius,
                shape: shape,
                image: DecorationImage(
                  image: imageProvider,
                  fit: fit ?? BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => shimmerImage(),
            errorWidget: (context, url, error) => placeholderImage(),
          )
        : placeholderImage();
  }

  Widget shimmerImage() {
    return SizedBox(
      height: height,
      width: width,
      child: Shimmer.fromColors(
        baseColor: AppColors.neutral6,
        highlightColor: AppColors.white,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: boxShadow,
            color: AppColors.neutral3.withOpacity(0.7),
            borderRadius: borderRadius,
            shape: shape,
          ),
        ),
      ),
    );
  }

  Widget placeholderImage() {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          boxShadow: boxShadow,
          color: shape == BoxShape.circle
              ? const Color(0xFFF2F2F6)
              : AppColors.neutral3.withOpacity(0.7),
          border: enableBorder && progress == null
              ? Border.all(
                  color: borderColor != null
                      ? borderColor!
                      : darkBorder
                          ? const Color(0xFF2D2D49)
                          : AppColors.white,
                  width: borderSize)
              : null,
          borderRadius: borderRadius,
          shape: shape,
          /*  image: shape == BoxShape.circle
              ? const DecorationImage(
                  image: AssetImage("assets/img/user-placeholder.svg"),
                  fit: BoxFit.contain)
              : null, */
        ),
        child: Center(
            child: shape != BoxShape.circle
                ? Icon(
                    Icons.image_rounded,
                    color: AppColors.white,
                    size: height * 0.3,
                  )
                : SvgPicture.asset(
                    ImageConstants.user,
                    height: height * 0.5,
                    colorFilter:
                        ColorFilter.mode(Color(0xFF7C7CA2), BlendMode.srcIn),
                  )));
  }
}
