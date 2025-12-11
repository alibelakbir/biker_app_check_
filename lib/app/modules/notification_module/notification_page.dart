import 'package:biker_app/app/modules/notification_module/widgets/notification_item.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/back_oval_widget.dart';
import 'package:biker_app/app/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../app/modules/notification_module/notification_controller.dart';

class NotificationPage extends GetWidget<NotificationController> {
  const NotificationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          backgroundColor: AppColors.white,
          centerTitle: true,
          systemUiOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          iconColor: AppColors.black,
          titleWidget: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackOvalWidget(
                backgroundColor: Color(0xFFECECEC),
              ),
              Text(
                'Notification',
                style: AppTextStyles.base.s32.w700.blackColor,
              ),
              SizedBox(width: 32)
            ],
          ),
        ),
        body: Obx(
          () => ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.notificationList.length,
            separatorBuilder: (_, __) => const SizedBox(height: 24),
            itemBuilder: (context, index) => NotificationItem(
                notification: controller.notificationList[index]),
          ),
        ));
  }
}
