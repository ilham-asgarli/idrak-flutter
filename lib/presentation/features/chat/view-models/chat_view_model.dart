import 'dart:async';

import 'package:emekteb/core/base/view-models/base_view_model.dart';
import 'package:emekteb/data-domain/security/modules/chat_contact_controller.dart';
import 'package:emekteb/presentation/features/chat/notifiers/chat_notifier.dart';

import '../../../../core/init/network/IResponseModel.dart';
import '../../../../data-domain/security/modules/chat_message_from_controller.dart';
import '../../../../data-domain/security/modules/chat_message_to_controller.dart';
import '../../../../data-domain/security/services/security_service.dart';
import '../../../../utils/app/constants/enums/api_enum.dart';

class ChatViewModel with BaseViewModel {
  late ChatContactController? chatContactController;
  late ChatNotifier chatNotifier;

  SecurityService securityService = SecurityService();
  StreamSocket streamSocket = StreamSocket();

  List<ChatMessageFromContent>? baseChatMessageFromContent = [];

  @override
  void init(context) async {
    super.init(context);

    baseChatMessageFromContent =
        (await getChatMessageFromList(chatContactController?.username, 0, 50))
            ?.content;

    await listenToNewMessages();
  }

  bool isNewDay(List<ChatMessageFromContent>? contents, int index) {
    if (contents != null && index == contents.length - 1) {
      return true;
    }

    return DateTime.parse(contents?[index].dateTime ?? "").day !=
        DateTime.parse(contents?[index + 1].dateTime ?? "").day;
  }

  Future<void> loadOldMessages() async {
    chatNotifier.changeIsLoadingOldMessages(true);
    baseChatMessageFromContent = [
      ...?baseChatMessageFromContent,
      ...?(await getChatMessageFromListByMessageId(
              chatContactController?.username,
              baseChatMessageFromContent?.last.id,
              CHAT_MESSAGE_SEARCH_TYPE.BEFORE,
              0,
              50))
          ?.content,
    ];
    streamSocket.add(baseChatMessageFromContent);
    chatNotifier.changeIsLoadingOldMessages(false);
  }

  Future<void> listenToNewMessages() async {
    while (true) {
      List<ChatMessageFromContent>? newList = [];

      if (baseChatMessageFromContent != null &&
          baseChatMessageFromContent!.isNotEmpty) {
        newList = (await getChatMessageFromListByMessageId(
                chatContactController?.username,
                baseChatMessageFromContent?.first.id,
                CHAT_MESSAGE_SEARCH_TYPE.AFTER,
                0,
                50))
            ?.content;

        baseChatMessageFromContent = [
          ...?newList,
          ...?baseChatMessageFromContent,
        ];
      } else {
        newList = (await getChatMessageFromList(
                chatContactController?.username, 0, 50))
            ?.content;

        baseChatMessageFromContent = [
          ...?newList,
        ];
      }

      streamSocket.add(baseChatMessageFromContent);

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

  Future<ChatMessageFromController?> getChatMessageFromListByMessageId(
    String? username,
    String? messageId,
    CHAT_MESSAGE_SEARCH_TYPE chatMessageSearchType,
    num page,
    num size,
  ) async {
    IResponseModel<ChatMessageFromController?> responseModel =
        await securityService.fetchChatMessageFromByMessageId(
      accessToken,
      username,
      messageId,
      chatMessageSearchType,
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
      StreamController<List<ChatMessageFromContent>?>.broadcast();

  void Function(List<ChatMessageFromContent>?) get add =>
      _socketResponse.sink.add;

  Stream<List<ChatMessageFromContent>?> get getStream =>
      _socketResponse.stream.asBroadcastStream();
}
