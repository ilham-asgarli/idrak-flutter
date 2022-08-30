import 'dart:async';

import 'package:emekteb/core/base/view-models/base_view_model.dart';
import 'package:emekteb/data-domain-layer/security/modules/chat_contact_controller.dart';

import '../../../../core/init/network/IResponseModel.dart';
import '../../../../data-domain-layer/security/modules/chat_message_from_controller.dart';
import '../../../../data-domain-layer/security/services/security_service.dart';

class ChatViewModel with BaseViewModel {
  late ChatContactController? chatContactController;

  SecurityService securityService = SecurityService();
  StreamSocket streamSocket = StreamSocket();

  @override
  void init(context) async {
    super.init(context);

    while (true) {
      List<ChatMessageFromController?>? chatMessageFromControllers =
          await getChatMessageFromList(chatContactController?.username);

      streamSocket.add(chatMessageFromControllers);

      await Future<void>.delayed(const Duration(seconds: 3));
    }
  }

  Future<List<ChatMessageFromController?>?> getChatMessageFromList(
    String? username,
  ) async {
    IResponseModel<List<ChatMessageFromController?>> responseModel =
        await securityService.fetchChatMessageFrom(accessToken, username);

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
