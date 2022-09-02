import 'dart:async';

import 'package:emekteb/core/base/view-models/base_view_model.dart';
import 'package:emekteb/data-domain-layer/security/modules/chat_contact_controller.dart';
import 'package:emekteb/presentation-layer/features/chat/notifiers/chat_notifier.dart';

import '../../../../core/init/network/IResponseModel.dart';
import '../../../../data-domain-layer/security/modules/chat_message_from_controller.dart';
import '../../../../data-domain-layer/security/modules/chat_message_to_controller.dart';
import '../../../../data-domain-layer/security/services/security_service.dart';

class ChatViewModel with BaseViewModel {
  late ChatContactController? chatContactController;
  late ChatNotifier chatNotifier;

  SecurityService securityService = SecurityService();
  StreamSocket streamSocket = StreamSocket();

  @override
  void init(context) async {
    super.init(context);

    while (true) {
      ChatMessageFromController? chatMessageFromController =
          await getChatMessageFromList(chatContactController?.username, 0, 100);

      streamSocket.add(chatMessageFromController);

      await Future<void>.delayed(const Duration(seconds: 1));
    }
  }

  void sendMessage(
    String? username,
    String? message,
  ) async {
    chatNotifier.changeIsSendingMessage(true);
    await getChatMessageToList(username, message);
    chatNotifier.changeIsSendingMessage(false);
  }

  Future<ChatMessageFromController?> getChatMessageFromList(
    String? username,
    page,
    size,
  ) async {
    IResponseModel<ChatMessageFromController?> responseModel =
        await securityService.fetchChatMessageFrom(
      accessToken,
      username,
      page,
      size,
    );

    return responseModel.data;
  }

  Future<ChatMessageToController?> getChatMessageToList(
    String? username,
    String? message,
  ) async {
    IResponseModel<ChatMessageToController> responseModel =
        await securityService.fetchChatMessageTo(
            accessToken, username, message);

    return responseModel.data;
  }
}

class StreamSocket {
  final _socketResponse =
      StreamController<ChatMessageFromController?>.broadcast();

  void Function(ChatMessageFromController?) get add => _socketResponse.sink.add;

  Stream<ChatMessageFromController?> get getStream =>
      _socketResponse.stream.asBroadcastStream();
}
