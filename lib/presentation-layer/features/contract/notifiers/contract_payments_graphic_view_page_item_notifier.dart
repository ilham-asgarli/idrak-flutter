import '../../../../core/base/notifier/base_change_notifier.dart';

class ContractPaymentsGraphicViewPageItemNotifier extends BaseChangeNotifier {
  int activeIndex = 0;

  changeActiveIndex(activeIndex) {
    this.activeIndex = activeIndex;
    notifyListeners();
  }
}