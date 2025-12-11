import 'dart:async';

import 'package:biker_app/app/data/api/api_connect_2.dart';
import 'package:biker_app/app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:biker_app/app/data/model/chat_message.dart';
import 'package:biker_app/app/data/model/chat_room.dart';
import 'package:async/async.dart';

class ChatProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new chat room with participant info and advertisement
  Future<String> createChatRoom(
    Map<String, dynamic> advertisement,
    List<Map<String, dynamic>> participants,
  ) async {
    // advertisement: {id: int, title: string, name: string}
    List<String> uids = participants.map((e) => e['uid'] as String).toList();
    String chatRoomId = getChatRoomId(
      advertisement['id'] as int,
      uids[0],
      uids[1],
    );

    // Check if chat room already exists
    DocumentSnapshot chatRoomDoc =
        await _firestore.collection(EndPoints.fChatRooms).doc(chatRoomId).get();

    if (!chatRoomDoc.exists) {
      // Create new chat room
      await _firestore.collection(EndPoints.fChatRooms).doc(chatRoomId).set({
        'advertisement': advertisement,
        'advertisementId': advertisement['id'],
        'participants': participants,
        'participantUids': uids,
        'lastMessage': '',
        'lastMessageTime': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    return chatRoomId;
  }

  // Send a message
  Future<void> sendMessage(ChatMessage message, int advertisementId) async {
    String chatRoomId = getChatRoomId(
      advertisementId,
      message.senderId,
      message.receiverId,
    );

    // Add message to chat room
    await _firestore
        .collection(EndPoints.fChatRooms)
        .doc(chatRoomId)
        .collection('messages')
        .add(message.toMap());

    // Update last message in chat room
    await _firestore.collection(EndPoints.fChatRooms).doc(chatRoomId).update({
      'lastMessage': message.message,
      'lastMessageTime': FieldValue.serverTimestamp(),
    });
  }

  // Get messages for a chat room
  Stream<List<ChatMessage>> getMessages(
    int advertisementId,
    String userId1,
    String userId2,
  ) {
    String chatRoomId = getChatRoomId(advertisementId, userId1, userId2);

    return _firestore
        .collection(EndPoints.fChatRooms)
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ChatMessage.fromFirestore(doc))
              .toList();
        });
  }

  // Get user's chat rooms
  Stream<QuerySnapshot> getUserChatRooms(String userId) {
    return _firestore
        .collection(EndPoints.fChatRooms)
        .where('participantUids', arrayContains: userId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots();
  }

  // Get user's chat rooms with pagination
  Future<List<DocumentSnapshot>> getUserChatRoomsPaginated(
    String userId, {
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async {
    Query query = _firestore
        .collection(EndPoints.fChatRooms)
        .where('participantUids', arrayContains: userId)
        .orderBy('lastMessageTime', descending: true)
        .limit(limit);
    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }
    final snapshot = await query.get();
    return snapshot.docs;
  }

  // Get unread message count for a chat room for a user
  Future<int> getUnreadCount(String chatRoomId, String receiverUid) async {
    final snapshot =
        await _firestore
            .collection(EndPoints.fChatRooms)
            .doc(chatRoomId)
            .collection('messages')
            .where('receiverId', isEqualTo: receiverUid)
            .where('isRead', isEqualTo: false)
            .get();
    return snapshot.docs.length;
  }

  // Mark all messages as read for a chat room and user
  Future<void> markMessagesAsRead(String chatRoomId, String receiverUid) async {
    final batch = _firestore.batch();
    final query =
        await _firestore
            .collection(EndPoints.fChatRooms)
            .doc(chatRoomId)
            .collection('messages')
            .where('receiverId', isEqualTo: receiverUid)
            .where('isRead', isEqualTo: false)
            .get();
    for (final doc in query.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();
  }

  // Get unread message count as a stream for real-time updates
  Stream<int> getUnreadCountStream(String chatRoomId, String receiverUid) {
    return _firestore
        .collection(EndPoints.fChatRooms)
        .doc(chatRoomId)
        .collection('messages')
        .where('receiverId', isEqualTo: receiverUid)
        .where('isRead', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  // Get last message as a stream for a chat room
  Stream<String> getLastMessageStream(String chatRoomId) {
    return _firestore
        .collection(EndPoints.fChatRooms)
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.isNotEmpty
                  ? snapshot.docs.first['message'] as String
                  : '',
        );
  }

  // Get total unread message count for all chat rooms for a user as a stream
  Stream<int> getTotalUnreadCountStream({String? userId}) {
    if (userId == null || userId.isEmpty) {
      return Stream.value(0);
    }
    // Create a StreamController to manage the main stream of unread counts.
    late StreamController<int> controller;

    // Use a variable to hold the subscription to the chat rooms stream.
    StreamSubscription<QuerySnapshot>? chatRoomsSubscription;

    // Use a variable to hold the subscription to the combined unread count stream.
    StreamSubscription<List<int>>? unreadCountSubscription;

    controller = StreamController<int>(
      onListen: () {
        // When the controller is first listened to, subscribe to the chat rooms.
        chatRoomsSubscription = _firestore
            .collection(EndPoints.fChatRooms)
            .where('participantUids', arrayContains: userId)
            .snapshots()
            .listen(
              (chatRoomsSnapshot) {
                // Cancel the previous combined stream subscription to avoid memory leaks.
                unreadCountSubscription?.cancel();

                // If there are no chat rooms, the total unread count is 0.
                if (chatRoomsSnapshot.docs.isEmpty) {
                  controller.add(0);
                  return;
                }

                // Create a list of streams, one for each chat room.
                final unreadStreams =
                    chatRoomsSnapshot.docs.map((roomDoc) {
                      return roomDoc.reference
                          .collection('messages')
                          .where('receiverId', isEqualTo: userId)
                          .where('isRead', isEqualTo: false)
                          .snapshots()
                          .map(
                            (messagesSnapshot) => messagesSnapshot.docs.length,
                          );
                    }).toList();

                // Use `StreamZip` to combine the streams. This will emit a `List<int>`
                // whenever any of the unreadStreams emit a new value.
                final combinedStream = StreamZip(unreadStreams);

                // Listen to the combined stream and sum the counts.
                unreadCountSubscription = combinedStream.listen(
                  (list) {
                    int total = 0;
                    for (final count in list) {
                      total += count;
                    }
                    controller.add(total);
                  },
                  onError: controller.addError,
                  onDone: controller.close,
                );
              },
              onError: controller.addError,
              onDone: controller.close,
            );
      },
      onCancel: () {
        // When the controller is no longer listened to, cancel all subscriptions.
        chatRoomsSubscription?.cancel();
        unreadCountSubscription?.cancel();
      },
    );

    return controller.stream;
  }

  // Helper function to generate consistent chat room IDs
  String getChatRoomId(int advertisementId, String userId1, String userId2) {
    // Sort user IDs to ensure consistent chat room ID regardless of who initiates
    List<String> userIds = [userId1, userId2]..sort();
    return '${advertisementId}_${userIds[0]}_${userIds[1]}';
  }

  // Fetch a single chat room by its ID
  Future<ChatRoom?> getChatRoomById(String chatRoomId) async {
    try {
      final doc =
          await _firestore
              .collection(EndPoints.fChatRooms)
              .doc(chatRoomId)
              .get();
      if (doc.exists) {
        return ChatRoom.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String?> getAdStatus(id, type) async {
    final resp =
        (await ApiConnect2.instance.get(
          '${type == 'moto' ? EndPoints.motoDetail : EndPoints.equipementDetail}/$id',
        )).getData();
    return resp['etatannonce'];
  }

  // Clear all messages in a specific chat room
  Future<void> clearChatRoomMessages(String chatRoomId) async {
    final messagesRef = _firestore
        .collection(EndPoints.fChatRooms)
        .doc(chatRoomId)
        .collection('messages');

    // Get all messages
    final messagesSnapshot = await messagesRef.get();

    // Delete all messages in batches
    final batch = _firestore.batch();
    for (final doc in messagesSnapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();

    // Update chat room to clear last message
    await _firestore.collection(EndPoints.fChatRooms).doc(chatRoomId).update({
      'lastMessage': '',
      'lastMessageTime': FieldValue.serverTimestamp(),
    });
  }

  // Delete entire chat room (including all messages)
  Future<void> deleteChatRoom(String chatRoomId) async {
    // Delete all messages first
    final messagesRef = _firestore
        .collection(EndPoints.fChatRooms)
        .doc(chatRoomId)
        .collection('messages');

    final messagesSnapshot = await messagesRef.get();
    final batch = _firestore.batch();
    for (final doc in messagesSnapshot.docs) {
      batch.delete(doc.reference);
    }

    // Delete the chat room document
    batch.delete(_firestore.collection(EndPoints.fChatRooms).doc(chatRoomId));

    await batch.commit();
  }

  // Clear all chat rooms for a user
  Future<void> clearAllUserChatRooms(String userId) async {
    // Get all chat rooms for the user
    final chatRoomsSnapshot =
        await _firestore
            .collection(EndPoints.fChatRooms)
            .where('participantUids', arrayContains: userId)
            .get();

    // Delete each chat room
    for (final roomDoc in chatRoomsSnapshot.docs) {
      await deleteChatRoom(roomDoc.id);
    }
  }
}
