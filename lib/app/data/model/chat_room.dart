import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String id;
  final List<Map<String, dynamic>>
      participants; // Each: {uid: string, name: string}
  final String lastMessage;
  final DateTime? lastMessageTime;
  final DateTime? createdAt;
  final Map<String, dynamic>
      advertisement; // {id: int, title: String, name: String}

  ChatRoom({
    required this.id,
    required this.participants,
    required this.lastMessage,
    this.lastMessageTime,
    this.createdAt,
    required this.advertisement,
  });

  factory ChatRoom.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatRoom(
        id: doc.id,
        participants: (data['participants'] as List?)
                ?.map((e) => Map<String, dynamic>.from(e))
                .toList() ??
            [],
        lastMessage: data['lastMessage'] ?? '',
        lastMessageTime: data['lastMessageTime'] != null
            ? (data['lastMessageTime'] as Timestamp).toDate()
            : null,
        createdAt: data['createdAt'] != null
            ? (data['createdAt'] as Timestamp).toDate()
            : null,
        advertisement: Map<String, dynamic>.from(data['advertisement']));
  }

  Map<String, dynamic> toMap() {
    return {
      'participants': participants,
      'lastMessage': lastMessage,
      'lastMessageTime':
          lastMessageTime != null ? Timestamp.fromDate(lastMessageTime!) : null,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'advertisement': advertisement,
    };
  }
}
