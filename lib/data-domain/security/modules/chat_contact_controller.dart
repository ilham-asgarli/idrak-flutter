import 'package:emekteb/core/base/models/base_model.dart';

class ChatContactController extends BaseModel<ChatContactController> {
  String? username;
  String? role;
  String? fullName;
  int? unreadMessagesCount;

  ChatContactController({
    this.username,
    this.role,
    this.fullName,
    this.unreadMessagesCount,
  });

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['role'] = role;
    data['fullName'] = fullName;
    data['unreadMessagesCount'] = unreadMessagesCount;
    return data;
  }

  @override
  ChatContactController fromJson(Map<String, dynamic> json) {
    return ChatContactController(
      username: json['username'],
      role: json['role'],
      fullName: json['fullName'],
      unreadMessagesCount: json['unreadMessagesCount'],
    );
  }
}
