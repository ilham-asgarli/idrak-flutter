import 'package:emekteb/core/base/notifiers/base_change_notifier.dart';

class ContractPaymentsNotifier extends BaseChangeNotifier {
  bool isMainDataLoading = true;
  int activeIndex = 0;

  reset() {
    isDisposed = false;
    isMainDataLoading = true;
    activeIndex = 0;
  }

  changeIsMainLoading(bool isMainDataLoading) {
    this.isMainDataLoading = isMainDataLoading;
    notifyListeners();
  }

  changeActiveIndex(int activeIndex) {
    this.activeIndex = activeIndex;
    notifyListeners();
  }
}
