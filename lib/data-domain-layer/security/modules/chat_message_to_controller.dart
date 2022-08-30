import 'package:emekteb/core/base/models/base_model.dart';

class ChatMessageToController extends BaseModel<ChatMessageToController> {
  dynamic id;
  dynamic message;
  dynamic userFrom;
  dynamic userTo;
  dynamic dateTime;
  bool? owner;
  bool? NEW;

  ChatMessageToController(
      {this.id,
      this.message,
      this.userFrom,
      this.userTo,
      this.dateTime,
      this.owner,
      this.NEW});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    data['userFrom'] = userFrom;
    data['userTo'] = userTo;
    data['dateTime'] = dateTime;
    data['owner'] = owner;
    data['new'] = NEW;
    return data;
  }

  @override
  ChatMessageToController fromJson(Map<String, dynamic> json) {
    return ChatMessageToController(
      id: json['id'],
      message: json['message'],
      userFrom: json['userFrom'],
      userTo: json['userTo'],
      dateTime: json['dateTime'],
      owner: json['owner'],
      NEW: json['new'],
    );
  }
}
