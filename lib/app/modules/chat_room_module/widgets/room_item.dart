import 'package:biker_app/app/data/model/chat_room.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_raduis.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/image_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:biker_app/app/data/provider/chat_provider.dart';

class RoomItem extends StatelessWidget {
  final ChatRoom room;

  const RoomItem({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    final currentUid = Get.find<FirebaseAuth>().currentUser?.uid;
    final receiver = room.participants.firstWhere(
      (p) => p['uid'] != currentUid,
      orElse: () => {'name': '?', 'id': '?'},
    );
    final chatProvider = ChatProvider();
    return GestureDetector(
      onTap: () {
        // Navigate to chat page with this user
        Get.toNamed('/chat', arguments: {
          'receiverId': receiver['uid'],
          'receiverName': receiver['name'],
          'receiverPhone': receiver['phone'],
          'ad': room.advertisement,
          'roomId': room.id
        });
      },
      child: Container(
        decoration: kRoomDeco,
        padding: EdgeInsets.all(12),
        child: Row(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 40,
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  borderRadius: kRadius10, color: AppColors.kPrimaryColor),
              child: Image.asset(
                ImageConstants.chat,
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
                          receiver['name'] ?? '',
                          style: AppTextStyles.base.s16.w600.blackColor,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        formatRelativeDate(room.lastMessageTime!),
                        style: AppTextStyles.base.s10.w500.kPrimaryColor,
                      )
                    ],
                  ),
                  Text(
                    '${room.advertisement['name']} ${room.advertisement['title']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.base.s12.w600.blackColor,
                  ),
                  Row(
                    spacing: 6,
                    children: [
                      Expanded(
                        child: StreamBuilder<String>(
                          stream: chatProvider.getLastMessageStream(room.id),
                          builder: (context, snapshot) {
                            final lastMessage =
                                (snapshot.hasData && snapshot.data!.isNotEmpty)
                                    ? snapshot.data!
                                    : room.lastMessage;
                            return Text(
                              lastMessage,
                              style: AppTextStyles.base.s12.w600
                                  .copyWith(color: Color(0xFF989898)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            );
                          },
                        ),
                      ),
                      StreamBuilder<int>(
                        stream: chatProvider.getUnreadCountStream(
                            room.id, currentUid ?? ''),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data! > 0) {
                            return Badge(
                              backgroundColor: AppColors.kPrimaryColor,
                              label: Text(
                                '${snapshot.data}',
                                style: AppTextStyles.base.s8.w600.whiteColor,
                              ),
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ],
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
