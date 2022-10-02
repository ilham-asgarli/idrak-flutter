import '../../../../core/base/notifiers/base_change_notifier.dart';

class ContractPaymentsGraphicViewPageItemNotifier extends BaseChangeNotifier {
  int activeIndex = 0;

  reset() {
    activeIndex = 0;
    isDisposed = false;
  }

  changeActiveIndex(activeIndex) {
    this.activeIndex = activeIndex;
    notifyListeners();
  }
}
