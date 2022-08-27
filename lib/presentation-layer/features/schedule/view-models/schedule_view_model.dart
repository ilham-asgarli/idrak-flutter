import 'package:easy_localization/easy_localization.dart';
import 'package:emekteb/core/base/view-models/base_view_model.dart';
import 'package:emekteb/data-domain-layer/school/modules/scheduler_controller.dart';
import 'package:emekteb/data-domain-layer/school/modules/week_yearly_controller.dart';
import 'package:emekteb/data-domain-layer/school/modules/yearly_controller.dart';
import 'package:emekteb/utils/constants/app/app_constants.dart';

import '../../../../core/init/network/IResponseModel.dart';
import '../../../../data-domain-layer/school/modules/class_yearly_controller.dart';
import '../../../../data-domain-layer/school/services/school_service.dart';
import '../../../../utils/constants/enums/enums.dart';
import '../../../../utils/models/choosing_end_drawer_item.dart';
import '../../../../utils/models/main_end_drawer_item.dart';
import '../models/schedule_filter.dart';
import '../notifiers/schedule_notifier.dart';

class ScheduleViewModel with BaseViewModel {
  late ScheduleNotifier scheduleNotifier;

  SchedulerController? schedulerController;
  ScheduleFilter? scheduleFilter;
  SchoolService schoolService = SchoolService();

  @override
  init(context) async {
    super.init(context);

    await getFilterDataAndChangeState();
    await getDataAndChangeState();
  }

  setMainEndDrawerItems(ScheduleFilter? scheduleFilter) {
    scheduleNotifier.changeMainEndDrawerItems(
        AppConstants.scheduleMainEndDrawerItemTitleKeys.map((e) {
      int index = AppConstants.scheduleMainEndDrawerItemTitleKeys.indexOf(e);

      return MainEndDrawerItem(
        e.tr(),
        choosingEndDrawerItems:
            getChoosingEndDrawerItemsByIndex(index, scheduleFilter),
        selectedChoosingEndDrawerItemIndex: scheduleNotifier
                .mainEndDrawerItems[index].choosingEndDrawerItems!.isNotEmpty
            ? scheduleNotifier
                .mainEndDrawerItems[index].selectedChoosingEndDrawerItemIndex
            : getSelectedIndexByMainEndDrawerIndex(index),
      );
    }).toList());
  }

  onTapChoosingEndDrawerItem(mainIndex, choosingIndex) async {
    scheduleNotifier.changeMainEndDrawerItemSelectedChoosingEndDrawerItemIndex(
      mainIndex,
      choosingIndex,
    );
    scheduleNotifier.changeEndDrawerEnum(SCHEDULE_END_DRAWER.MAIN);

    if (mainIndex == AppConstants.scheduleEndDrawerYearIndex) {
      await getFilterDataAndChangeState(yearIndex: choosingIndex);
    }

    await getDataAndChangeState();
  }

  Future<SchedulerController?> getScheduleControllerByParameters() async {
    int selectedWeekIndex = scheduleNotifier
        .mainEndDrawerItems[AppConstants.scheduleEndDrawerWeekIndex]
        .selectedChoosingEndDrawerItemIndex;
    int selectedClassIndex = scheduleNotifier
        .mainEndDrawerItems[AppConstants.scheduleEndDrawerClassIndex]
        .selectedChoosingEndDrawerItemIndex;

    try {
      String? classYearId =
          scheduleFilter?.schoolClassYearly?.result?[selectedClassIndex].id;
      int? weekId =
          scheduleFilter?.schoolWeekYearly?.result?[selectedWeekIndex].id;
      SchedulerController? schoolScheduler =
          await getSchoolScheduler(classYearId, weekId.toString());

      return schoolScheduler;
    } catch (e) {
      return null;
    }
  }

  List<ChoosingEndDrawerItem>? getChoosingEndDrawerItemsByIndex(
    index,
    ScheduleFilter? timetableFilter,
  ) {
    switch (index) {
      case AppConstants.scheduleEndDrawerYearIndex:
        return timetableFilter?.schoolYearly?.result!
            .map((e) => ChoosingEndDrawerItem(title: e.info))
            .toList();
      case AppConstants.scheduleEndDrawerWeekIndex:
        return timetableFilter?.schoolWeekYearly?.result!
            .map((e) => ChoosingEndDrawerItem(
                  title: "${e.startWeek} - ${e.endWeek}",
                ))
            .toList();
      case AppConstants.scheduleEndDrawerClassIndex:
        return timetableFilter?.schoolClassYearly?.result!
            .map((e) => ChoosingEndDrawerItem(
                  title: "${e.classPrefix} ${e.classPrefixIndicator}",
                ))
            .toList();
    }
    return null;
  }

  int getSelectedIndexByMainEndDrawerIndex(index) {
    switch (index) {
      case AppConstants.scheduleEndDrawerYearIndex:
        return getCurrentYearIndex(scheduleFilter?.schoolYearly);
      case AppConstants.scheduleEndDrawerWeekIndex:
        return getCurrentWeekIndex(scheduleFilter?.schoolWeekYearly);
      default:
        return 0;
    }
  }

  int getCurrentYearIndex(YearlyController? schoolYearly) {
    int index = 0;
    schoolYearly?.result?.forEach((e) {
      if (e.isCurrent != null && e.isCurrent!) {
        index = schoolYearly.result!.indexOf(e);
      }
    });
    return index;
  }

  int getCurrentWeekIndex(WeekYearlyController? schoolWeekYearly) {
    int index = 0;
    schoolWeekYearly?.result?.forEach((e) {
      if (e.isCurrent != null && e.isCurrent!) {
        index = schoolWeekYearly.result!.indexOf(e);
      }
    });
    return index;
  }

  int scheduleDayListLength() {
    return schedulerController?.result?.days?.length ?? 0;
  }

  Future<void> getDataAndChangeState() async {
    if (!scheduleNotifier.isBodyWidgetLoading) {
      scheduleNotifier.changeIsBodyWidgetLoading(true);
    }

    await getData().then((value) {
      schedulerController = value;
      scheduleNotifier.changeIsBodyWidgetLoading(false);
    });
  }

  Future<void> getFilterDataAndChangeState({int? yearIndex}) async {
    if (!scheduleNotifier.isChoosingEndDrawerLoading) {
      scheduleNotifier.changeIsChoosingEndDrawerLoading(true);
    }

    if (!scheduleNotifier.isBodyWidgetLoading) {
      scheduleNotifier.changeIsBodyWidgetLoading(true);
    }

    scheduleFilter = await getFilterDataByYear(yearIndex: yearIndex);
    setMainEndDrawerItems(scheduleFilter);
    scheduleNotifier.changeIsChoosingEndDrawerLoading(false);
  }

  Future<SchedulerController?> getData() async {
    SchedulerController? schoolScheduler =
        await getScheduleControllerByParameters();
    return schoolScheduler;
  }

  /// If [yearIndex] is null year index is current year.
  Future<ScheduleFilter> getFilterDataByYear({int? yearIndex}) async {
    YearlyController? schoolYearly = scheduleFilter == null
        ? await getYearList()
        : scheduleFilter?.schoolYearly;

    int index = yearIndex ?? getCurrentYearIndex(schoolYearly);

    ClassYearlyController? schoolClassYearly = await getSchoolClassYearly(
      schoolYearly?.result?[index].id,
    );
    WeekYearlyController? schoolWeekYearly = await getSchoolWeekYearly(
      schoolYearly?.result?[index].id,
    );

    return ScheduleFilter(
      schoolYearly: schoolYearly,
      schoolClassYearly: schoolClassYearly,
      schoolWeekYearly: schoolWeekYearly,
    );
  }

  Future<YearlyController?> getYearList() async {
    IResponseModel<YearlyController> responseModel =
        await schoolService.fetchYearList(accessToken);

    return responseModel.data;
  }

  Future<ClassYearlyController?> getSchoolClassYearly(String? yearId) async {
    IResponseModel<ClassYearlyController> responseModel =
        await schoolService.fetchClassList(accessToken, yearId);

    return responseModel.data;
  }

  Future<WeekYearlyController?> getSchoolWeekYearly(String? yearId) async {
    IResponseModel<WeekYearlyController> responseModel =
        await schoolService.fetchWeekList(accessToken, yearId);

    return responseModel.data;
  }

  Future<SchedulerController?> getSchoolScheduler(
      String? classYearId, String? weekId) async {
    IResponseModel<SchedulerController> responseModel =
        await schoolService.fetchScheduler(accessToken, classYearId, weekId);

    return responseModel.data;
  }
}
