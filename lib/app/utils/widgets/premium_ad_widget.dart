import 'package:biker_app/app/data/model/premium_ad.dart';
import 'package:biker_app/app/data/provider/premium_ads_provider.dart';
import 'package:biker_app/app/modules/web_view.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/enums.dart';
import 'package:biker_app/app/utils/widgets/app_button/app_button.dart';
import 'package:biker_app/app/utils/widgets/cached_image.dart';
import 'package:biker_app/app/utils/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PremiumAdWidget extends StatefulWidget {
  PremiumAdWidget({
    super.key,
    required this.ad,
    required this.premiumAdsProvider,
    this.detectVisibility = true,
  }) {
    adType = PremiumAdType.banner;
  }
  PremiumAdWidget.card({
    super.key,
    required this.ad,
    required this.premiumAdsProvider,
    this.detectVisibility = true,
  }) {
    adType = PremiumAdType.card;
  }

  PremiumAdWidget.icon({
    super.key,
    required this.ad,
    required this.premiumAdsProvider,
    this.detectVisibility = false,
  }) {
    adType = PremiumAdType.icon;
  }
  final PremiumAd ad;
  final PremiumAdsProvider premiumAdsProvider;
  final bool detectVisibility;
  late final PremiumAdType adType;

  @override
  State<PremiumAdWidget> createState() => _PremiumAdWidgetState();
}

class _PremiumAdWidgetState extends State<PremiumAdWidget> {
  bool _hasReachedVisibility = false;

  @override
  Widget build(BuildContext context) {
    void ontap() {
      widget.premiumAdsProvider.clickPremiumAd(widget.ad.idpremiumads);
      Get.toNamed(
        AppRoutes.webView,
        arguments: WebViewScreen(
          appBarText: widget.ad.titre,
          url: widget.ad.redirectUrl.replaceAll('usp=dialog', ''),
        ),
      );
    }

    return VisibilityDetector(
      key: Key(
        'premium_ad-${widget.ad.idpremiumads}-${widget.ad.nomEntreprise}',
      ),
      onVisibilityChanged:
          !widget.detectVisibility
              ? null
              : (VisibilityInfo info) {
                double visiblePercentage = info.visibleFraction * 100;
                if (visiblePercentage > 50 && !_hasReachedVisibility) {
                  _hasReachedVisibility = true;
                  widget.premiumAdsProvider.reachPremiumAd(
                    widget.ad.idpremiumads,
                  );
                  debugPrint(
                    '✅ PremiumAd banner is visible more than 50% - API called once',
                  );
                }
              },
      child: GestureDetector(
        onTap: ontap,
        child:
            widget.adType == PremiumAdType.banner
                ? CachedImage(
                  imageUrl: 'https://biker.ma/${widget.ad.imageUrl}',
                  height: 132,
                  fit: BoxFit.contain,
                ).marginSymmetric(horizontal: 16)
                : widget.adType == PremiumAdType.card
                ? CardWidget(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: kRadius5,
                    border: Border.all(width: 1, color: Color(0xFFE6E6E6)),
                  ),
                  margin: EdgeInsets.only(bottom: 16),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 6,
                        children: [
                          CachedImage(
                            imageUrl: 'https://biker.ma/${widget.ad.logo}',
                            borderRadius: kRadius10,
                            height: 27,
                            width: 27,
                          ),
                          Text(
                            widget.ad.nomEntreprise,
                            style: AppTextStyles.base.s13.w600.blackColor,
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 8, vertical: 10),
                      Container(
                        constraints: BoxConstraints(maxHeight: 360),
                        child: CachedImage(
                          imageUrl: 'https://biker.ma/${widget.ad.imageUrl}',
                          borderRadius: kRadius10,
                          // height: 400,
                          // width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Row(
                        spacing: 12,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.ad.titre,
                                  style:
                                      AppTextStyles.base.s14.w500.kPrimaryColor,
                                ),
                                Text(
                                  widget.ad.texte,
                                  style: AppTextStyles.base.s12.w400.copyWith(
                                    color: Color(0xFF8A8A8A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: AppButton(
                              height: 32,
                              onPressed: ontap,
                              text: 'En savoir plus',
                              style: AppTextStyles.base.w600.s12.whiteColor,
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero,
                              borderRadius: kRadius5,
                            ),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 8, vertical: 10),
                    ],
                  ),
                )
                : widget.adType == PremiumAdType.icon
                ? Container(
                  constraints: BoxConstraints(maxWidth: 70, maxHeight: 70),
                  child: CachedImage(
                    imageUrl: 'https://biker.ma/${widget.ad.imageUrl}',
                    fit: BoxFit.contain,
                  ),
                ).paddingOnly(top: 32)
                : SizedBox.shrink(),
      ),
    );
  }
}
