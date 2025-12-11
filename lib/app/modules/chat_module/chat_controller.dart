import 'dart:developer';

import 'package:biker_app/app/data/api/api.checker.dart';
import 'package:biker_app/app/data/api/api_error.dart';
import 'package:biker_app/app/data/model/chat_room.dart';
import 'package:biker_app/app/modules/profile_module/profile_controller.dart';
import 'package:biker_app/app/utils/common.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:biker_app/app/data/model/chat_message.dart';
import 'package:biker_app/app/data/provider/chat_provider.dart';
import 'package:biker_app/app/utils/analytics_mixin.dart';

class ChatController extends GetxController with AnalyticsMixin {
  final ChatProvider provider;
  final String receiverId;
  final String receiverName;
  final String receiverPhone;
  final Map<String, dynamic> ad;
  final String? roomId;

  ChatController({
    required this.provider,
    required this.receiverId,
    required this.receiverName,
    required this.receiverPhone,
    required this.ad,
    this.roomId,
  });

  final currentUser = Get.find<FirebaseAuth>().currentUser;
  final messages = <ChatMessage>[].obs;
  final messageController = TextEditingController();
  final isLoading = false.obs;
  final loadedRoom = Rx<ChatRoom?>(null);
  final isAdActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAdStatus();
    _loadMessages();
    if (roomId != null) loadRoomById(roomId!);
    markAllAsRead();

    // Track chat page view
    trackPageView(
      pageName: 'Chat',
      parameters: {
        'receiver_id': receiverId,
        'ad_id': ad['id'],
        'has_room_id': roomId != null,
      },
    );
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  void _loadMessages() {
    if (currentUser == null) return;

    provider.getMessages(ad['id'], currentUser!.uid, receiverId).listen((
      newMessages,
    ) {
      messages.value = newMessages;
    });
  }

  Future<void> sendMessage() async {
    if (currentUser == null || messageController.text.trim().isEmpty) return;

    final message = ChatMessage(
      id: '', // Will be set by Firestore
      senderId: currentUser!.uid,
      receiverId: receiverId,
      message: messageController.text.trim(),
      timestamp: DateTime.now(),
    );

    try {
      isLoading.value = true;
      // Prepare participant info
      final participants = [
        {
          'uid': currentUser!.uid,
          'name': Get.find<ProfileController>().appUser?.nom ?? 'Moi',
          'phone': Get.find<ProfileController>().appUser?.telephone,
          'seller': false,
        },
        {
          'uid': receiverId,
          'name': receiverName,
          'phone': receiverPhone,
          'seller': true,
        },
      ];
      log(ad.toString() + '//' + participants.toString());
      final roomId = await provider.createChatRoom(ad, participants);
      if (loadedRoom.value == null) loadRoomById(roomId);
      await provider.sendMessage(message, ad['id']);
      messageController.clear();
    } catch (e) {
      Common.showError('Échec de l’envoi du message. Veuillez réessayer.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markAllAsRead() async {
    if (currentUser == null) return;
    final chatRoomId = provider.getChatRoomId(
      ad['id'],
      currentUser!.uid,
      receiverId,
    );
    await provider.markMessagesAsRead(chatRoomId, currentUser!.uid);
    log('markMessagesAsRead');
  }

  // Load a single chat room by its ID and update observable
  Future<void> loadRoomById(String chatRoomId) async {
    loadedRoom.value = null;
    final room = await provider.getChatRoomById(chatRoomId);
    log('room: ${room?.toMap()}');
    loadedRoom.value = room;
  }

  getAdStatus() async {
    try {
      final result = await provider.getAdStatus(ad['id'], ad['type'] ?? 'moto');
      if (result != null && result == 'active') {
        isAdActive.value = true;
      }
    } on ApiErrors catch (e) {
      ApiChecker.checkApi(e);
    }
  }
}
