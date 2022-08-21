import '../../../../core/base/notifier/base_change_notifier.dart';

class ContractPaymentsGraphicViewPageNotifier extends BaseChangeNotifier {
  int activeIndex = 0;

  changeActiveIndex(activeIndex) {
    this.activeIndex = activeIndex;
    notifyListeners();
  }
}