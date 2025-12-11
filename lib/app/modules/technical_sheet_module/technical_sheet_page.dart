import 'dart:io';

import 'package:biker_app/app/data/model/brand.dart';
import 'package:biker_app/app/data/model/brand_moto.dart';
import 'package:biker_app/app/modules/photo_view_page.dart';
import 'package:biker_app/app/modules/technical_sheet_module/model/info_model.dart';
import 'package:biker_app/app/modules/technical_sheet_module/widgets/expansion_panel_info.dart';
import 'package:biker_app/app/modules/technical_sheet_module/widgets/price_name_widget.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/utils/extensions.dart';
import 'package:biker_app/app/utils/helpers.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:biker_app/app/utils/svg_image.dart';
import 'package:biker_app/app/utils/widgets/app_button/app_button.dart';
import 'package:biker_app/app/utils/widgets/carousel_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/modules/technical_sheet_module/technical_sheet_controller.dart';
import 'widgets/info_widget.dart';
import 'widgets/seller_widget.dart';

class TechnicalSheetPage extends GetWidget<TechnicalSheetController> {
  final Brand brand;
  final BrandMoto moto;
  const TechnicalSheetPage({
    super.key,
    required this.brand,
    required this.moto,
  });
  @override
  Widget build(BuildContext context) {
    var moteurList = [
      InfoModel(label: 'Type', text: moto.moteur),
      InfoModel(label: 'Alimentation', text: moto.alimentation),
      InfoModel(label: 'Couple maximal', text: moto.couplemax),
      InfoModel(label: 'Alésage X course', text: moto.alesage),
    ];

    var transmissionList = [
      InfoModel(label: 'Embrayage', text: moto.embrayage),
      InfoModel(label: 'Transmission', text: moto.boiteavitesse),
      InfoModel(
        label: 'Transmission Secondaire',
        text: moto.transmissionsecondaire,
      ),
    ];

    var suspensionList = [
      InfoModel(label: 'Suspension avant', text: moto.suspensionavant),
      InfoModel(label: 'Suspension arrière', text: moto.suspensionarriere),
    ];

    var freinList = [
      InfoModel(label: 'ABS', text: moto.abs),
      InfoModel(label: 'Freins avant', text: moto.freinavant),
      InfoModel(label: 'Freins arrière', text: moto.freinarriere),
    ];

    var chassisList = [
      InfoModel(label: 'Châssis', text: moto.chassis),
      InfoModel(label: 'Réservoir', text: moto.reservoir),
      InfoModel(label: 'Hauteur selle', text: moto.hauteurselle),
      InfoModel(label: 'Hauteur selle', text: moto.hauteurselle),
      InfoModel(label: 'Hauteur', text: moto.hauteur),
      InfoModel(label: 'Longeur', text: moto.longueur),
      InfoModel(label: 'Largeur', text: moto.largeur),
    ];

    var pneuList = [
      InfoModel(label: 'Pneu avant', text: moto.pneumatiqueavant),
      InfoModel(label: 'Pneu arrière', text: moto.pneumatiquearriere),
    ];
    var poidList = [
      InfoModel(label: 'Poids Vide', text: moto.poidsvide),
      InfoModel(label: 'Poids Max', text: moto.poidsaveccharge),
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.size.height * 0.35,
              child: Stack(
                children: [
                  Hero(
                    tag: 'moto-${moto.id}',
                    child: CarouselImages(
                      gallery: moto.medias.withoutNullsOrEmpty(),
                      type: 'fiche_moto',
                      dotColor: Color(0xff76767669),
                      dotIncreasedColor: Color(0xFF767676),
                    ),
                  ),
                  Positioned(
                    top: kToolbarHeight,
                    left: 16,
                    right: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipOval(
                          child: Container(
                            color: AppColors.white,
                            child: const BackButton(
                              color: AppColors.white,
                              style: ButtonStyle(
                                iconSize: WidgetStatePropertyAll(20),
                                iconColor: WidgetStatePropertyAll(
                                  AppColors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Container(
                            color: AppColors.white,
                            child: IconButton(
                              onPressed: () async {},
                              icon: const Icon(Icons.share_outlined),
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            PriceNameWidget(moto: moto),
            InfoWidget(ad: moto).paddingSymmetric(vertical: 20),
            Column(
              spacing: 16,
              children: [
                ExpansionTileInfo(title: 'Moteur', infos: moteurList),
                ExpansionTileInfo(
                  title: 'Transmission',
                  infos: transmissionList,
                ),
                ExpansionTileInfo(title: 'Suspensions', infos: suspensionList),
                ExpansionTileInfo(title: 'Freins', infos: freinList),
                ExpansionTileInfo(
                  title: 'Châssis & Dimensions',
                  infos: chassisList,
                ),
                ExpansionTileInfo(title: 'Pneus', infos: pneuList),
                ExpansionTileInfo(title: 'Poids', infos: poidList),
              ],
            ),
            SellerWidget(brand: brand),
            SizedBox(height: Get.context!.mediaQueryPadding.bottom),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            top: 24,
            bottom:
                Get.context!.mediaQueryPadding.bottom +
                (Platform.isAndroid ? 16 : 0),
          ),
          decoration: BoxDecoration(
            borderRadius: kTopRadius,
            border: Border(
              top: BorderSide(color: Color(0xFFE8E8E8), width: 1),
              left: BorderSide.none,
              right: BorderSide.none,
              bottom: BorderSide.none,
            ),
          ),
          child: Row(
            spacing: 8,
            children: [
              Expanded(
                child: AppButton(
                  height: 44,
                  onPressed: () {},
                  prefixIcon: SvgImage(
                    ImageConstants.phone,
                    height: 22,
                    color: Colors.white,
                  ),
                  space: 0,
                  margin: EdgeInsets.zero,
                  text: 'Contacter',
                ),
              ),
              Expanded(
                child: AppButton(
                  height: 44,
                  onPressed: () {},
                  prefixIcon: Image.asset(ImageConstants.scooter, height: 22),
                  margin: EdgeInsets.zero,
                  text: 'Test drive',
                  space: 0,
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 16),
        ),
      ),
    );
  }
}
