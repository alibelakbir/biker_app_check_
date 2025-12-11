import 'dart:developer';

import 'package:biker_app/app/modules/advertisement_details_module/advertisement_details_page.dart';
import 'package:biker_app/app/routes/app_pages.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:biker_app/app/utils/helpers.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:biker_app/app/utils/svg_image.dart';
import 'package:biker_app/app/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:biker_app/app/utils/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:biker_app/app/modules/chat_module/chat_controller.dart';
import 'package:biker_app/app/utils/date_converter.dart';

class ChatPage extends GetWidget<ChatController> {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (popResult, r) async {
        await controller.markAllAsRead();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: controller.receiverName.capitalizeFirst,
          titleStyle: AppTextStyles.base.s18.w700.whiteColor,
          centerTitle: true,
          actions: [
            Obx(() {
              final room = controller.loadedRoom.value;
              if (room == null || !controller.isAdActive.value) {
                return SizedBox.shrink();
              }

              final currentUid = controller.currentUser?.uid;
              // Find the participant object for the current user
              final other = room.participants.firstWhere(
                (p) => p['uid'] != currentUid,
              );
              // Only show the IconButton if the current user is NOT the seller
              log(other.toString());
              if (other['seller'] == true) {
                return IconButton(
                  onPressed: () => Helpers.openTel(other['phone']),
                  icon: SvgImage(
                    ImageConstants.phone,
                    height: 22,
                    color: Colors.white,
                  ),
                );
              }
              return SizedBox();
            }),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Obx(
                () =>
                    controller.loadedRoom.value != null
                        ? GestureDetector(
                          onTap:
                              () => Get.toNamed(
                                AppRoutes.advertisementDetails,
                                arguments: AdvertisementDetailsPage(
                                  id:
                                      controller
                                          .loadedRoom
                                          .value!
                                          .advertisement['id'],
                                  isMoto:
                                      controller
                                              .loadedRoom
                                              .value!
                                              .advertisement['type'] !=
                                          null &&
                                      controller
                                              .loadedRoom
                                              .value!
                                              .advertisement['type'] ==
                                          'moto',
                                  category:
                                      controller
                                          .loadedRoom
                                          .value!
                                          .advertisement['category'] ??
                                      'moto',
                                ),
                              ),
                          child: Container(
                            width: double.infinity,
                            decoration: kLightCardDecoration,
                            padding: EdgeInsets.all(16),
                            child: Row(
                              spacing: 12,
                              children: [
                                CachedImage(
                                  imageUrl: EndPoints.mediaUrl(
                                    '${controller.loadedRoom.value!.advertisement['photo']}',
                                  ),
                                  height: 44,
                                  width: 44,
                                  borderRadius: kRadius4,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 2,
                                    children: [
                                      Text(
                                        controller.isAdActive.value
                                            ? '${controller.loadedRoom.value!.advertisement['name']} ${controller.loadedRoom.value!.advertisement['title']}'
                                            : 'Annonce non disponible',
                                        style:
                                            AppTextStyles
                                                .base
                                                .s14
                                                .w500
                                                .blackColor,
                                      ),
                                      Text(
                                        'Voir l\'annonce',
                                        style: AppTextStyles
                                            .base
                                            .s11
                                            .w400
                                            .kPrimaryColor
                                            .copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor:
                                                  AppColors.kPrimaryColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        : SizedBox.shrink(),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.messages.isEmpty) {
                    return Center(
                      child: Text(
                        'No messages yet. Start the conversation!',
                        style: AppTextStyles.base.s14.w400.grayColor,
                      ),
                    );
                  }
                  return Obx(
                    () => ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.all(16),
                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        final message = controller.messages[index];
                        final isMe =
                            message.senderId == controller.currentUser?.uid;

                        return Align(
                          alignment:
                              isMe
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width * 0.3,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isMe
                                      ? AppColors.kPrimaryColor
                                      : Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.message,
                                  style: TextStyle(
                                    color: isMe ? Colors.white : Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  DateConverter.timeAgoCustomFr(
                                    message.timestamp,
                                  ),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        isMe ? Colors.white70 : Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, -1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.messageController,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          hintText: 'Tapez un message…',
                          border: InputBorder.none,
                          hintStyle: AppTextStyles.base.s14.w400.grayColor,
                        ),
                        style: AppTextStyles.base.s16.w500.blackColor,
                        maxLines: null,
                      ),
                    ),
                    Obx(() {
                      return !controller.isAdActive.value
                          ? SizedBox.shrink()
                          : IconButton(
                            onPressed:
                                controller.isLoading.value
                                    ? null
                                    : controller.sendMessage,
                            icon:
                                controller.isLoading.value
                                    ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                    : const Icon(
                                      Icons.send,
                                      color: AppColors.kPrimaryColor,
                                    ),
                          );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
