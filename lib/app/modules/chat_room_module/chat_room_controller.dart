import 'dart:developer';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:biker_app/app/data/model/chat_room.dart';
import 'package:biker_app/app/data/provider/chat_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomController extends GetxController {
  final ChatProvider provider;
  ChatRoomController({required this.provider});

  User? currentUser;
  final rooms = <ChatRoom>[].obs;
  final isLoading = false.obs;
  final hasMore = true.obs;
  DocumentSnapshot? lastDoc;
  final int pageSize = 20;

  Future<void> loadRooms({bool loadMore = false}) async {
    currentUser = Get.find<FirebaseAuth>().currentUser;
    //if (!hasMore.value) hasMore.value = true;

    log(currentUser?.uid ?? 'null');
    if (isLoading.value || currentUser == null) return;
    isLoading.value = true;
    log(currentUser!.uid);
    try {
      final docs = await provider.getUserChatRoomsPaginated(
        currentUser!.uid,
        limit: pageSize,
        startAfter: loadMore ? lastDoc : null,
      );
      if (!loadMore) rooms.clear();
      if (docs.isNotEmpty) {
        lastDoc = docs.last;
        rooms.addAll(docs.map((doc) => ChatRoom.fromFirestore(doc)));
        if (docs.length < pageSize) hasMore.value = false;
      } else {
        hasMore.value = false;
      }
    } finally {
      isLoading.value = false;
    }
  }

  void loadMoreRooms() => loadRooms(loadMore: true);

  // Clear messages in a specific chat room
  Future<void> clearChatRoomMessages(String chatRoomId) async {
    try {
      await provider.clearChatRoomMessages(chatRoomId);
      log('Chat room messages cleared: $chatRoomId');
      // Refresh the rooms list to update UI
      loadRooms();
    } catch (e) {
      log('Error clearing chat room messages: $e');
    }
  }

  // Delete a specific chat room
  Future<void> deleteChatRoom(String chatRoomId) async {
    try {
      await provider.deleteChatRoom(chatRoomId);
      log('Chat room deleted: $chatRoomId');
      // Refresh the rooms list to update UI
      loadRooms();
    } catch (e) {
      log('Error deleting chat room: $e');
    }
  }

  // Clear all chat rooms for current user
  Future<void> clearAllChatRooms() async {
    if (currentUser == null) return;

    try {
      await provider.clearAllUserChatRooms(currentUser!.uid);
      log('All chat rooms cleared for user: ${currentUser!.uid}');
      // Clear local rooms list
      rooms.clear();
    } catch (e) {
      log('Error clearing all chat rooms: $e');
    }
  }
}
