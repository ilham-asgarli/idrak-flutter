import 'package:easy_localization/easy_localization.dart';
import 'package:emekteb/core/base/notifier/base_change_notifier.dart';
import 'package:emekteb/utils/constants/app/app_constants.dart';
import 'package:emekteb/utils/constants/enums/enums.dart';

import '../../../../data-domain-layer/school/modules/scheduler_controller.dart';
import '../models/main_end_drawer_item.dart';

class TimetableNotifier extends BaseChangeNotifier {
  List<MainEndDrawerItem> mainEndDrawerItems = AppConstants.mainEndDrawerItemTitleKeys
      .map((e) => MainEndDrawerItem(e.tr()))
      .toList();
  int activePage = 0;
  int activeChoosingEndDrawer = 0;
  TIMETABLE_END_DRAWER endDrawerEnum = TIMETABLE_END_DRAWER.MAIN;
  bool isMainEndDrawerLoading = false;
  bool isChoosingEndDrawerLoading = true;
  bool isBodyWidgetLoading = true;
  late SchedulerController schoolScheduler;

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

  changeSchoolScheduler(schoolScheduler) {
    this.schoolScheduler = schoolScheduler;
    notifyListeners();
  }
}
