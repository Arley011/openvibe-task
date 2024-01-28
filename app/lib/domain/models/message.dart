import 'package:equatable/equatable.dart';

class Message extends Equatable {
  const Message(
      this.id,
      this.message,
      this.nickname,
      this.icon,
      this.createdAt,
      );

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      json['id'] as String,
      json['message'] as String,
      json['nickname'] as String,
      json['icon'] as String,
      DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
    );
  }

  final String id;
  final String message;
  final String nickname;
  final String icon;
  final DateTime createdAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'nickname': nickname,
      'icon': icon,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  @override
  List<Object?> get props => [
    id,
    message,
    nickname,
    icon,
    createdAt,
  ];
}
