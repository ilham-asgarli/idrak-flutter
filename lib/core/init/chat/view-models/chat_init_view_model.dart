import 'dart:async';

import 'package:emekteb/core/base/notifiers/base_change_notifier.dart';
import 'package:emekteb/core/base/view-models/base_view_model.dart';
import 'package:flutter/material.dart';

import '../../../../data-domain/security/modules/chat_contact_controller.dart';
import '../../../../data-domain/security/services/security_service.dart';
import '../../../constants/cache/hive_constants.dart';
import '../../network/IResponseModel.dart';

class ChatInitViewModel extends BaseChangeNotifier with BaseViewModel {
  SecurityService securityService = SecurityService();
  StreamSocket streamSocket = StreamSocket();

  int messageCount = 0;

  ChatInitViewModel(BuildContext context) {
    init(context);
  }

  reset() {
    isDisposed = false;
    messageCount = 0;
    streamSocket = StreamSocket();
  }

  @override
  void init(context) async {
    super.init(context);

    setChatStream();
  }

  changeMessageCount(int messageCount) {
    this.messageCount = messageCount;
    notifyListeners();
  }

  int calculateMessageCount(
      List<ChatContactController?>? chatContactControllers) {
    int count = 0;

    chatContactControllers?.forEach((e) {
      count += e?.unreadMessagesCount?.toInt() ?? 0;
    });

    return count;
  }

  void setChatStream() async {
    while (true) {
      if (!isDisposed) {
        List<ChatContactController?>? chatContactControllers =
            await getChatContactControllers();

        if (!streamSocket.socketResponse.isClosed) {
          streamSocket.add(chatContactControllers);
        }

        changeMessageCount(calculateMessageCount(chatContactControllers));
      }
      await Future<void>.delayed(const Duration(seconds: 2));
    }
  }

  Future<List<ChatContactController?>?> getChatContactControllers() async {
    IResponseModel<List<ChatContactController?>> responseModel =
        await securityService
            .fetchChatContacts(hiveBox.get(HiveConstants.accessToken));

    return responseModel.data;
  }
}

class StreamSocket {
  final socketResponse =
      StreamController<List<ChatContactController?>?>.broadcast();

  void Function(List<ChatContactController?>?) get add =>
      socketResponse.sink.add;

  Stream<List<ChatContactController?>?> get getStream =>
      socketResponse.stream.asBroadcastStream();
}
