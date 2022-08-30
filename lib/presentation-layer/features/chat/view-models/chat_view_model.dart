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
      List<ChatMessageFromController?>? chatMessageFromControllers =
          await getChatMessageFromList(chatContactController?.username);

      streamSocket.add(chatMessageFromControllers);

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

  Future<List<ChatMessageFromController?>?> getChatMessageFromList(
    String? username,
  ) async {
    IResponseModel<List<ChatMessageFromController?>> responseModel =
        await securityService.fetchChatMessageFrom(accessToken, username);

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
      StreamController<List<ChatMessageFromController?>?>.broadcast();

  void Function(List<ChatMessageFromController?>?) get add =>
      _socketResponse.sink.add;

  Stream<List<ChatMessageFromController?>?> get getStream =>
      _socketResponse.stream.asBroadcastStream();
}
