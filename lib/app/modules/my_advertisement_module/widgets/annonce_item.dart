import 'package:biker_app/app/data/model/advertisement.dart';
import 'package:biker_app/app/modules/my_advertisement_module/my_advertisement_controller.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/helpers.dart';
import 'package:biker_app/app/utils/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnnonceItem extends StatelessWidget {
  final Advertisement ad;
  final Function() onTapDisable;
  const AnnonceItem({super.key, required this.ad, required this.onTapDisable});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.only(top: 24, bottom: 8),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: Color(0xFFF6F6F6)))),
      child: Row(
        spacing: 12,
        children: [
          CachedImage(
            height: 100,
            width: 100,
            imageUrl: EndPoints.mediaUrl(ad.medias.first),
            borderRadius: kRadius14,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      ad.titre.capitalizeFirst ?? ad.titre,
                      style: AppTextStyles.base.s14.w500.blackColor,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )),
                    PopupMenuButton<String>(
                      color: AppColors.white,
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.more_horiz,
                        color: AppColors.black,
                      ),
                      onSelected: (value) async {
                        if (value == 'edit') {
                          await Get.toNamed(AppRoutes.newAdvertisement,
                              arguments: ad);
                          Get.find<MyAdvertisementController>().tabData();
                        } else if (value == 'disable') {
                          onTapDisable();
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            value: 'edit',
                            child: Text(
                              'Modifier',
                              style: AppTextStyles.base.s12.w500.blackColor,
                            )),
                        PopupMenuItem(
                            value: 'disable',
                            child: Text('Désactiver',
                                style: AppTextStyles.base.s12.w500
                                    .copyWith(color: Color(0xFFCD2C2C)))),
                      ],
                    ),
                  ],
                ),
                Helpers.etatAnnonce(ad.etatannonce),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(ad.prix != null ? Helpers.formatPrice(ad.prix!) : '',
                        style: AppTextStyles.base.s14.w700.kPrimaryColor),
                   /*  AppButton(
                      width: 94,
                      height: 24,
                      onPressed: () {},
                      text: 'Booster',
                      style: AppTextStyles.base.s12.w700.whiteColor,
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      margin: EdgeInsets.zero,
                      borderRadius: kRadius4,
                      prefixIcon:
                          Image.asset(ImageConstants.racingLogo, width: 23),
                      space: 0,
                    ) */
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
