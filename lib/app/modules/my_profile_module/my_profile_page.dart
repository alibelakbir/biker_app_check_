import 'package:biker_app/app/modules/my_profile_module/widgets/profile_info.dart';
import 'package:biker_app/app/modules/profile_module/models/menu.dart';
import 'package:biker_app/app/modules/profile_module/widgets/menu_item.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/back_oval_widget.dart';
import 'package:biker_app/app/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/modules/my_profile_module/my_profile_controller.dart';

class MyProfilePage extends GetWidget<MyProfileController> {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppBar(
          backgroundColor: AppColors.white,
          brightness: Brightness.light,
          titleWidget: Row(
            children: [BackOvalWidget(backgroundColor: Color(0xFFECECEC))],
          ),
          preferredSizeWidget: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: Row(
              children: [
                Text(
                  'Mon Profil',
                  textAlign: TextAlign.left,
                  style: AppTextStyles.base.s32.w600.blackColor,
                ).paddingSymmetric(horizontal: 16),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 32,
              children: [
                ProfileInfo(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Paramètres du compte',
                      style: AppTextStyles.base.s24.w500.blackColor,
                    ),
                    Column(
                      children:
                          myProfileList.map((e) => MenuItem(menu: e)).toList(),
                    ).paddingOnly(bottom: 16),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
