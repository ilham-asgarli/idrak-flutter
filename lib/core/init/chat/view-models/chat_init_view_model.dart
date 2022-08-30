import 'dart:async';

import 'package:emekteb/core/base/view-models/base_view_model.dart';

import '../../../../data-domain-layer/security/modules/chat_contact_controller.dart';
import '../../../../data-domain-layer/security/services/security_service.dart';
import '../../network/IResponseModel.dart';

class ChatInitViewModel extends BaseViewModel {
  SecurityService securityService = SecurityService();
  StreamSocket streamSocket = StreamSocket();

  ChatInitViewModel(context) {
    init(context);
  }

  @override
  void init(context) async {
    super.init(context);

    setChatStream();
  }

  void setChatStream() async {
    while (true) {
      List<ChatContactController?>? chatContactControllers =
          await getChatContactControllers();
      streamSocket.add(chatContactControllers);

      await Future<void>.delayed(const Duration(seconds: 3));
    }
  }

  Future<List<ChatContactController?>?> getChatContactControllers() async {
    IResponseModel<List<ChatContactController?>> responseModel =
        await securityService.fetchChatContacts(accessToken);

    return responseModel.data;
  }
}

class StreamSocket {
  final _socketResponse =
      StreamController<List<ChatContactController?>?>.broadcast();

  void Function(List<ChatContactController?>?) get add =>
      _socketResponse.sink.add;

  Stream<List<ChatContactController?>?> get getStream =>
      _socketResponse.stream.asBroadcastStream();
}
