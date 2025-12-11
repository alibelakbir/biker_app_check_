import 'package:biker_app/app/modules/auth_module/tabs/login_tab.dart';
import 'package:biker_app/app/modules/auth_module/tabs/register_tab.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:biker_app/app/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:biker_app/app/utils/widgets/app_button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../../../app/modules/auth_module/auth_controller.dart';

class AuthPage extends GetWidget<AuthController> {
  const AuthPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        backgroundColor: AppColors.white,
        brightness: Brightness.light,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Text(
                "Commencez Maintenant",
                style: AppTextStyles.base.s24.w700.blackColor,
              ),
              SizedBox(height: 12),
              Text(
                "Créez un compte ou connectez-vous",
                style: AppTextStyles.base.s14.w400.copyWith(
                  color: Color(0xFF6C7278),
                ),
              ),
              SizedBox(height: 24),
              Material(
                color: Color(0xFFF5F6F9),
                borderOnForeground: false,
                borderRadius: kRadius6,
                elevation: 5,
                shadowColor: Color.fromRGBO(0, 0, 0, 0.02),
                child: TabBar(
                  controller: controller.tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerHeight: 0,
                  indicatorPadding: const EdgeInsets.all(6),
                  tabs: [Tab(text: 'Se connecter'), Tab(text: 'S’inscrire')],
                  labelColor: Color(0xFF232447),
                  unselectedLabelColor: Color(0xFF7D7D91),
                  labelStyle: AppTextStyles.base.s14.w500,
                  indicator: RectangularIndicator(
                    bottomLeftRadius: 12,
                    bottomRightRadius: 12,
                    topLeftRadius: 12,
                    topRightRadius: 12,
                    paintingStyle: PaintingStyle.fill,
                    color: AppColors.white,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () =>
                    controller.tabIndex.value == 0 ? LoginTab() : RegisterTab(),
              ),
             
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Obx(
          () =>
              controller.tabIndex.value == 0
                  ? SizedBox.shrink()
                  : AppButton(
                    onPressed: () => controller.signUp(context),
                    text: 'Inscription',
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  ),
        ),
      ),
    );
  }
}
