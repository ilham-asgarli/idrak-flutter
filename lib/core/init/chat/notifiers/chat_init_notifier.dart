import 'package:emekteb/core/base/notifiers/base_change_notifier.dart';

class ChatInitNotifier extends BaseChangeNotifier {
  int messageCount = 0;

  changeMessageCount(int messageCount) {
    this.messageCount = messageCount;
    notifyListeners();
  }
}