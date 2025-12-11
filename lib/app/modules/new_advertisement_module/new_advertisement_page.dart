import 'package:biker_app/app/themes/app_raduis.dart';

import 'tabs/tab_0.dart';
import 'tabs/tab_1.dart';
import 'tabs/tab_2.dart';
import 'tabs/tab_3.dart';
import 'tabs/tab_4.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_theme.dart';
import '../../utils/back_oval_widget.dart';
import '../../utils/widgets/app_bar/custom_app_bar.dart';
import '../../utils/widgets/app_button/app_button.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/modules/new_advertisement_module/new_advertisement_controller.dart';
import 'widgets/header_widget.dart';

class NewAdvertisementPage extends GetWidget<NewAdvertisementController> {
  const NewAdvertisementPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleWidget: Row(children: [BackOvalWidget()]),

        preferredSizeWidget: PreferredSize(
          preferredSize: const Size.fromHeight(108),
          child: Column(
            children: [
              Obx(() => HeaderWidget(pageIndex: controller.pageIndex.value)),
              Obx(() {
                return LinearProgressIndicator(
                  value: (controller.pageIndex.value + 1) / 5,
                  backgroundColor: AppColors.kSecondaryColor,
                  color: AppColors.kAccentColor,
                );
              }),
            ],
          ),
        ),
        actions: [
          Obx(
            () => Text(
              '${controller.pageIndex.value + 1}/5',
              style: AppTextStyles.base.s13.w600.whiteColor,
            ).paddingSymmetric(horizontal: 16),
          ),
        ],
      ),
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(), // 🚫 Disable swipe
        children: [Tab0(), Tab1(), Tab2(), Tab3(), Tab4()],
        onPageChanged: (value) => controller.setPageIndex(value),
      ),
      bottomNavigationBar: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: Obx(
          () =>
              controller.pageIndex.value == 0
                  ? SizedBox.shrink()
                  : SafeArea(
                    top: false,
                    child: Container(
                      height: 90,
                      padding: EdgeInsets.only(bottom: 16),
                      decoration: kLightCardDecoration.copyWith(
                        borderRadius: null,
                      ),
                      child: Row(
                        children: [
                          controller.pageIndex.value > 1
                              ? Expanded(
                                child: AppButton.outline(
                                  height: 48,
                                  margin: EdgeInsets.symmetric(horizontal: 12),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  onPressed: controller.onTapPrevious,
                                  text: "Précédent",

                                  //borderRadius: kRadius12,
                                ),
                              )
                              : SizedBox.shrink(),
                          Expanded(
                            child: AppButton(
                              onPressed: controller.onTapNext,
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),

                              text:
                                  controller.pageIndex.value != 4
                                      ? "Suivant"
                                      : controller.advertisement != null
                                      ? "Modifier l'annonce"
                                      : "Ajouter l'annonce",
                              //borderRadius: kRadius12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
        ),
      ),
    );
  }
}
