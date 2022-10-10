import 'package:easy_localization/easy_localization.dart';
import 'package:emekteb/core/base/notifiers/base_change_notifier.dart';

import '../constants/constants.dart';
import '../../../../utils/ui/models/main_end_drawer_item.dart';
import '../constants/enums.dart';

class ScheduleNotifier extends BaseChangeNotifier {
  List<MainEndDrawerItem> mainEndDrawerItems = Constants.scheduleMainEndDrawerItemTitleKeys
      .map((e) => MainEndDrawerItem(e.tr()))
      .toList();
  int activePage = 0;
  int activeChoosingEndDrawer = 0;
  SCHEDULE_END_DRAWER endDrawerEnum = SCHEDULE_END_DRAWER.MAIN;
  bool isMainEndDrawerLoading = false;
  bool isChoosingEndDrawerLoading = true;
  bool isBodyWidgetLoading = true;

  changeMainEndDrawerItems(List<MainEndDrawerItem> mainEndDrawerItems) {
    this.mainEndDrawerItems = mainEndDrawerItems;
    notifyListeners();
  }

  changeMainEndDrawerItemSelectedChoosingEndDrawerItemIndex(
      index, selectedChoosingEndDrawerItemIndex) {
    mainEndDrawerItems[index].selectedChoosingEndDrawerItemIndex =
        selectedChoosingEndDrawerItemIndex;
    notifyListeners();
  }

  changeActivePage(activePage) {
    this.activePage = activePage;
    notifyListeners();
  }

  changeIsMainEndDrawerLoading(bool isMainEndDrawerLoading) {
    this.isMainEndDrawerLoading = isMainEndDrawerLoading;
    notifyListeners();
  }

  changeIsChoosingEndDrawerLoading(bool isChoosingEndDrawerLoading) {
    this.isChoosingEndDrawerLoading = isChoosingEndDrawerLoading;
    notifyListeners();
  }

  changeIsBodyWidgetLoading(bool isBodyWidgetLoading) {
    this.isBodyWidgetLoading = isBodyWidgetLoading;
    notifyListeners();
  }

  changeEndDrawerEnum(endDrawerEnum) {
    this.endDrawerEnum = endDrawerEnum;
    notifyListeners();
  }

  changeActiveChoosingEndDrawer(activeChoosingEndDrawer) {
    this.activeChoosingEndDrawer = activeChoosingEndDrawer;
    notifyListeners();
  }
}
