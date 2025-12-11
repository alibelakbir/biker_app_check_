import 'dart:developer';

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:biker_app/app/modules/photo_view_page.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cached_image.dart';

import '../../themes/app_colors.dart';

class CarouselImages extends StatelessWidget {
  final List<String?> gallery;
  final double dotVerticalPadding;
  final BorderRadiusGeometry? raduis;
  final String? type;
  final Color? dotIncreasedColor;
  final Color? dotColor;

  const CarouselImages(
      {super.key,
      required this.gallery,
      this.dotVerticalPadding = 16.0,
      this.raduis,
      this.type,
      this.dotIncreasedColor,
      this.dotColor});

  @override
  Widget build(BuildContext context) {
    log('Gallery: ${gallery.map((e) => e)}');

    return gallery.isEmpty
        ? Container(
            width: double.infinity,
            decoration:
                BoxDecoration(color: AppColors.neutral3.withOpacity(0.7)),
            child: const Center(
              child:
                  Icon(Icons.image_rounded, color: AppColors.white, size: 64),
            ),
          )
        : AnotherCarousel(
            images: List.generate(gallery.length, (index) {
              log('Ohoto :${type != null ? EndPoints.brandMotoMediaUrl(gallery[index]) : EndPoints.mediaUrl(gallery[index])}');
              return CachedImage(
                imageUrl: type != null
                    ? EndPoints.brandMotoMediaUrl(gallery[index])
                    : EndPoints.mediaUrl(gallery[index]),
                enableBorder: false,
                borderRadius: raduis,
              );
            }),
            dotSize: 6.0,
            dotSpacing: 15.0,
            dotColor: dotColor ?? AppColors.white.withOpacity(0.7),
            dotVerticalPadding: dotVerticalPadding,
            dotIncreasedColor: dotIncreasedColor ?? AppColors.white,
            indicatorBgPadding: 5.0,
            dotBgColor: Colors.transparent,
            //borderRadius: true,
            autoplay: false,
            showIndicator: gallery.length > 1,
            onImageTap: (p0) => Get.toNamed(AppRoutes.photoView,
                arguments: PhotoViewerPage(
                    imageUrls: gallery.withoutNullsOrEmpty(),
                    initialIndex: p0, type: type,)),
          );
  }
}
