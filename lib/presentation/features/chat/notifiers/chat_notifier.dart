import 'package:emekteb/core/base/notifiers/base_change_notifier.dart';

class ChatNotifier extends BaseChangeNotifier {
  bool isSendingMessage = false;
  bool isLoadingOldMessages = false;

  changeIsSendingMessage(bool isSendingMessage) {
    this.isSendingMessage = isSendingMessage;
    notifyListeners();
  }

  changeIsLoadingOldMessages(bool isLoadingOldMessages) {
    this.isLoadingOldMessages = isLoadingOldMessages;
    notifyListeners();
  }
}