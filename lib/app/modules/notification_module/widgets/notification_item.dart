import 'package:biker_app/app/data/model/notification.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:biker_app/app/utils/svg_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class NotificationItem extends StatelessWidget {
  final AppNotification notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: kRoomDeco,
        padding: EdgeInsets.all(12),
        child: Row(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 46,
              width: 46,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor, shape: BoxShape.circle),
              child: SvgImage(
                ImageConstants.bell,
                color: AppColors.white,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Row(
                    spacing: 6,
                    children: [
                      Expanded(
                        child: Text(
                          notification.title.trim().capitalizeFirst ?? '',
                          style: AppTextStyles.base.s16.w600.blackColor,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        formatRelativeDate(
                            DateTime.parse(notification.createdAt)),
                        style: AppTextStyles.base.s10.w500.kPrimaryColor,
                      )
                    ],
                  ),
                  Text(
                    notification.message.trim(),
                    style: AppTextStyles.base.s12.w600
                        .copyWith(color: Color(0xFF989898)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

String formatRelativeDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final aDate = DateTime(date.year, date.month, date.day);
  final diff = today.difference(aDate).inDays;
  if (diff == 0) return "Aujourd'hui";
  if (diff == 1) return "Hier";
  if (diff > 1 && diff < 7) return "Il y a $diff jours";
  return DateFormat('dd/MM/yyyy').format(date);
}
