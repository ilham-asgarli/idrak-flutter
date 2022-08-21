import 'package:easy_localization/easy_localization.dart';
import 'package:emekteb/core/base/view-models/base_view_model.dart';
import 'package:emekteb/data-domain-layer/school/modules/school_scheduler.dart';
import 'package:emekteb/data-domain-layer/school/modules/school_week_yearly.dart';
import 'package:emekteb/data-domain-layer/school/modules/school_yearly.dart';
import 'package:emekteb/utils/constants/app/app_constants.dart';

import '../../../../core/init/network/IResponseModel.dart';
import '../../../../data-domain-layer/school/modules/school_class_yearly.dart';
import '../../../../data-domain-layer/school/services/school_service.dart';
import '../../../../utils/constants/enums/enums.dart';
import '../models/choosing_end_drawer_item.dart';
import '../models/main_end_drawer_item.dart';
import '../models/timetable_filter.dart';
import '../notifiers/timetable_notifier.dart';

class TimetableViewModel with BaseViewModel {
  late TimetableNotifier timetableNotifier;
  TimetableFilter? timetableFilter;

  SchoolService timetableService = SchoolService();

  @override
  init(context) async {
    super.init(context);
    await getFilterDataAndChangeState();
    await getDataAndChangeState();
  }

  int timetableDayListLength() {
    return timetableNotifier.schoolScheduler.result?.days?.length ?? 0;
  }

  Future<void> getDataAndChangeState() async {
    if (!timetableNotifier.isBodyWidgetLoading) {
      timetableNotifier.changeIsBodyWidgetLoading(true);
    }

    await getData().then((value) {
      if (value != null) {
        timetableNotifier.changeSchoolScheduler(value);
        timetableNotifier.changeIsBodyWidgetLoading(false);
      }
    });
  }

  Future<void> getFilterDataAndChangeState({int? yearIndex}) async {
    if (!timetableNotifier.isChoosingEndDrawerLoading) {
      timetableNotifier.changeIsChoosingEndDrawerLoading(true);
    }

    if (!timetableNotifier.isBodyWidgetLoading) {
      timetableNotifier.changeIsBodyWidgetLoading(true);
    }

    await getFilterDataByYear(yearIndex: yearIndex).then((value) {
      setMainEndDrawerItems(value);
      timetableNotifier.changeIsChoosingEndDrawerLoading(false);
    });
  }

  Future<SchoolScheduler?> getData() async {
    SchoolScheduler? schoolScheduler = await getSchoolSchedulerByClassAndWeek();
    return schoolScheduler;
  }

  /// If [yearIndex] is null year index is current year.
  Future<TimetableFilter> getFilterDataByYear({int? yearIndex}) async {
    SchoolYearsController? schoolYearly = timetableFilter == null
        ? await getYearList()
        : timetableFilter!.schoolYearly;

    int index = yearIndex ?? getCurrentYearIndex(schoolYearly);

    SchoolClassYearly? schoolClassYearly =
        await getSchoolClassYearly(schoolYearly?.result?[index].id);
    SchoolWeekYearly? schoolWeekYearly =
        await getSchoolWeekYearly(schoolYearly?.result?[index].id);

    timetableFilter = TimetableFilter(
      schoolYearly: schoolYearly,
      schoolClassYearly: schoolClassYearly,
      schoolWeekYearly: schoolWeekYearly,
    );

    return timetableFilter!;
  }

  Future<SchoolYearsController?> getYearList() async {
    IResponseModel<SchoolYearsController> responseModel =
        await timetableService.fetchYearList(accessToken);

    return responseModel.data;
  }

  Future<SchoolClassYearly?> getSchoolClassYearly(String? yearId) async {
    IResponseModel<SchoolClassYearly> responseModel =
        await timetableService.fetchClassList(accessToken, yearId);

    return responseModel.data;
  }

  Future<SchoolWeekYearly?> getSchoolWeekYearly(String? yearId) async {
    IResponseModel<SchoolWeekYearly> responseModel =
        await timetableService.fetchWeekList(accessToken, yearId);

    return responseModel.data;
  }

  Future<SchoolScheduler?> getSchoolScheduler(
      String? classYearId, String? weekId) async {
    IResponseModel<SchoolScheduler> responseModel =
        await timetableService.fetchScheduler(accessToken, classYearId, weekId);

    return responseModel.data;
  }

  setMainEndDrawerItems(TimetableFilter timetableFilter) {
    timetableNotifier.changeMainEndDrawerItems(
        AppConstants.mainEndDrawerItemTitleKeys.map((e) {
      int index = AppConstants.mainEndDrawerItemTitleKeys.indexOf(e);

      return MainEndDrawerItem(
        e.tr(),
        choosingEndDrawerItems:
            getChoosingEndDrawerItemsByIndex(index, timetableFilter),
        selectedChoosingEndDrawerItemIndex: timetableNotifier
                .mainEndDrawerItems[index].choosingEndDrawerItems!.isNotEmpty
            ? timetableNotifier
                .mainEndDrawerItems[index].selectedChoosingEndDrawerItemIndex
            : getSelectedIndexByMainEndDrawerIndex(index),
      );
    }).toList());
  }

  onTapChoosingEndDrawerItem(mainIndex, choosingIndex) async {
    timetableNotifier.changeMainEndDrawerItemSelectedChoosingEndDrawerItemIndex(
        mainIndex, choosingIndex);
    timetableNotifier.changeEndDrawerEnum(TIMETABLE_END_DRAWER.MAIN);

    if (mainIndex == AppConstants.timetableEndDrawerYearIndex) {
      await getFilterDataAndChangeState(yearIndex: choosingIndex);
    }

    await getDataAndChangeState();
  }

  Future<SchoolScheduler?> getSchoolSchedulerByClassAndWeek() async {
    int selectedWeekIndex = timetableNotifier
        .mainEndDrawerItems[AppConstants.timetableEndDrawerWeekIndex]
        .selectedChoosingEndDrawerItemIndex;
    int selectedClassIndex = timetableNotifier
        .mainEndDrawerItems[AppConstants.timetableEndDrawerClassIndex]
        .selectedChoosingEndDrawerItemIndex;

    try {
      String classYearId =
          timetableFilter!.schoolClassYearly!.result![selectedClassIndex].id!;
      int weekId =
          timetableFilter!.schoolWeekYearly!.result![selectedWeekIndex].id!;
      SchoolScheduler? schoolScheduler =
          await getSchoolScheduler(classYearId, weekId.toString());
      return schoolScheduler;
    } catch (e) {
      return null;
    }
  }

  List<ChoosingEndDrawerItem>? getChoosingEndDrawerItemsByIndex(
      index, TimetableFilter timetableFilter) {
    switch (index) {
      case AppConstants.timetableEndDrawerYearIndex:
        return timetableFilter.schoolYearly?.result!
            .map((e) => ChoosingEndDrawerItem("${e.info}"))
            .toList();
      case AppConstants.timetableEndDrawerWeekIndex:
        return timetableFilter.schoolWeekYearly?.result!
            .map((e) => ChoosingEndDrawerItem("${e.startWeek} - ${e.endWeek}"))
            .toList();
      case AppConstants.timetableEndDrawerClassIndex:
        return timetableFilter.schoolClassYearly?.result!
            .map((e) => ChoosingEndDrawerItem(
                "${e.classPrefix} ${e.classPrefixIndicator}"))
            .toList();
    }
    return null;
  }

  int getSelectedIndexByMainEndDrawerIndex(index) {
    switch (index) {
      case AppConstants.timetableEndDrawerYearIndex:
        return getCurrentYearIndex(timetableFilter?.schoolYearly);
      case AppConstants.timetableEndDrawerWeekIndex:
        return getCurrentWeekIndex(timetableFilter?.schoolWeekYearly);
      default:
        return 0;
    }
  }

  int getCurrentYearIndex(SchoolYearsController? schoolYearly) {
    int index = 0;
    schoolYearly?.result?.forEach((e) {
      if (e.isCurrent != null && e.isCurrent!) {
        index = schoolYearly.result!.indexOf(e);
      }
    });
    return index;
  }

  int getCurrentWeekIndex(SchoolWeekYearly? schoolWeekYearly) {
    int index = 0;
    schoolWeekYearly?.result?.forEach((e) {
      if (e.isCurrent != null && e.isCurrent!) {
        index = schoolWeekYearly.result!.indexOf(e);
      }
    });
    return index;
  }
}
