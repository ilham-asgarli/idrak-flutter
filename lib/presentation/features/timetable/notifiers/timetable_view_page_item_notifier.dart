import '../../../../core/base/notifiers/base_change_notifier.dart';

class TimetableViewPageItemNotifier extends BaseChangeNotifier {
  int activeIndex = 0;

  reset() {
    activeIndex = 0;
    isDisposed = false;
  }

  changeActiveIndex(int activeIndex) {
    this.activeIndex = activeIndex;
    notifyListeners();
  }
}
