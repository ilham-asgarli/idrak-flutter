import 'package:emekteb/core/base/models/base_model.dart';

class ChatMessageFromController extends BaseModel<ChatMessageFromController> {
  String? id;
  String? message;
  UserFrom? userFrom;
  UserFrom? userTo;
  String? dateTime;
  bool? owner;

  ChatMessageFromController(
      {this.id,
      this.message,
      this.userFrom,
      this.userTo,
      this.dateTime,
      this.owner});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    if (userFrom != null) {
      data['userFrom'] = userFrom!.toJson();
    }
    if (userTo != null) {
      data['userTo'] = userTo!.toJson();
    }
    data['dateTime'] = dateTime;
    data['owner'] = owner;
    return data;
  }

  @override
  ChatMessageFromController fromJson(Map<String, dynamic> json) {
    return ChatMessageFromController(
      id: json['id'],
      message: json['message'],
      userFrom:
          json['userFrom'] != null ? UserFrom.fromJson(json['userFrom']) : null,
      userTo: json['userTo'] != null ? UserFrom.fromJson(json['userTo']) : null,
      dateTime: json['dateTime'],
      owner: json['owner'],
    );
  }
}

class UserFrom {
  String? username;
  String? password;
  dynamic ip;
  dynamic browser;
  dynamic device;
  dynamic os;

  UserFrom(
      {this.username,
      this.password,
      this.ip,
      this.browser,
      this.device,
      this.os});

  UserFrom.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    ip = json['ip'];
    browser = json['browser'];
    device = json['device'];
    os = json['os'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['ip'] = ip;
    data['browser'] = browser;
    data['device'] = device;
    data['os'] = os;
    return data;
  }
}
