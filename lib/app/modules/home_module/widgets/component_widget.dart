import 'package:biker_app/app/data/model/advertisement.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ad_widget.dart';

class ComponentWidget extends StatelessWidget {
  final String title;
  final List<Advertisement> ads;
  final bool showMore;
  final bool? isSimilar;
  final int? listingTabIndex;
  final String category;

  const ComponentWidget({
    super.key,
    required this.title,
    required this.ads,
    this.showMore = true,
    this.isSimilar = false,
    this.listingTabIndex,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyles.base.s16.w700.blackColor),
            !showMore
                ? SizedBox.shrink()
                : GestureDetector(
                  onTap:
                      () => Get.toNamed(
                        AppRoutes.listingMoto,
                        arguments: {'index': listingTabIndex},
                      ),
                  child: Text(
                    'Voir Plus',
                    style: AppTextStyles.base.s12.w600.copyWith(
                      color: Color(0xFF00B6B3),
                    ),
                  ),
                ),
          ],
        ).paddingSymmetric(horizontal: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: List.generate(
                ads.length,
                (index) => AdWidget(
                  advertisement: ads[index],
                  isSimilar: isSimilar,
                  isMoto: title.contains('Motos'),
                  category: category,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
