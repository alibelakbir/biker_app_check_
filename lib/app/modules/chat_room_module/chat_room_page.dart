import 'package:biker_app/app/modules/chat_room_module/widgets/room_item.dart';
import 'package:biker_app/app/themes/app_colors.dart';
import 'package:biker_app/app/themes/app_text_theme.dart';
import 'package:biker_app/app/utils/common.dart';
import 'package:biker_app/app/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'chat_room_controller.dart';

class ChatRoomPage extends GetWidget<ChatRoomController> {
  const ChatRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Message',
          titleStyle: AppTextStyles.base.s32.w700.blackColor,
          backgroundColor: AppColors.white,
          centerTitle: false,
          actions: [
            if (controller.rooms.isNotEmpty)
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: AppColors.black),
                onSelected: (value) async {
                  if (value == 'clear_all') {
                    final confirmed = await Get.dialog<bool>(
                      AlertDialog(
                        title: Text('Effacer toutes les conversations'),
                        content: Text(
                          'Êtes-vous sûr de vouloir effacer toutes les conversations ? Cette action est irréversible.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(result: false),
                            child: Text('Annuler'),
                          ),
                          TextButton(
                            onPressed: () => Get.back(result: true),
                            child: Text(
                              'Tout effacer',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );

                    if (confirmed == true) {
                      await controller.clearAllChatRooms();
                      Common.showSuccess(
                        title: 'Toutes les conversations ont été effacées.',
                      );
                    }
                  }
                },
                itemBuilder:
                    (context) => [
                      PopupMenuItem<String>(
                        value: 'clear_all',
                        child: Row(
                          children: [
                            Icon(Icons.clear_all, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Clear All Chats'),
                          ],
                        ),
                      ),
                    ],
              ),
          ],
          systemUiOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
        body: Obx(() {
          if (controller.rooms.isEmpty && controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.rooms.isEmpty) {
            return Center(
              child: Text(
                'No chat rooms yet.',
                style: AppTextStyles.base.s14.w400.grayColor,
              ),
            );
          }
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (!controller.isLoading.value &&
                  controller.hasMore.value &&
                  scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent - 100) {
                controller.loadMoreRooms();
              }
              return false;
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount:
                  controller.rooms.length + (controller.hasMore.value ? 1 : 0),
              separatorBuilder: (_, __) => const SizedBox(height: 24),
              itemBuilder: (context, index) {
                if (index == controller.rooms.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                final room = controller.rooms[index];
                return RoomItem(room: room);
              },
            ),
          );
        }),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  final String name;
  static final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.brown,
    Colors.indigo,
  ];
  const _ProfileAvatar({required this.name});

  Color _getColor(String input) {
    final int hash = input.isNotEmpty ? input.codeUnitAt(0) : 0;
    return _colors[hash % _colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final String displayChar = name.isNotEmpty ? name[0].toUpperCase() : '?';
    return CircleAvatar(
      backgroundColor: _getColor(name),
      child: Text(
        displayChar,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
