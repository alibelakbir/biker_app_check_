import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppNotification {
  int id;
  String title;
  String message;
  dynamic data;
  String createdAt;
  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.data,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'message': message,
      'data': data,
      'createdAt': createdAt,
    };
  }

  factory AppNotification.fromMap(Map<String, dynamic> map) {
    return AppNotification(
      id: map['id'] as int,
      title: map['title'] as String,
      message: map['message'] as String,
      data: map['data'] as dynamic,
      createdAt: map['created_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppNotification.fromJson(String source) =>
      AppNotification.fromMap(json.decode(source) as Map<String, dynamic>);
}
