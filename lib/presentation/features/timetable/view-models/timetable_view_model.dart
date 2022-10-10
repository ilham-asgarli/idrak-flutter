import 'package:easy_localization/easy_localization.dart';
import 'package:emekteb/core/base/view-models/base_view_model.dart';
import 'package:emekteb/utils/generics/constants/api/api_constants.dart';
import 'package:emekteb/utils/generics/constants/enums/api_enum.dart';
import 'package:emekteb/data-domain/school/modules/student_controller.dart';
import 'package:emekteb/data-domain/school/modules/timetable_controller.dart';
import 'package:emekteb/presentation/features/timetable/models/timetable_filter.dart';
import 'package:emekteb/presentation/features/timetable/notifiers/timetable_notifier.dart';
import 'package:emekteb/utils/ui/constants/enums/enums.dart';

import '../../../../core/init/network/IResponseModel.dart';
import '../../../../data-domain/school/modules/yearly_controller.dart';
import '../../../../data-domain/school/services/school_service.dart';
import '../../../../utils/ui/constants/app/app_constants.dart';
import '../../../../utils/ui/models/choosing_end_drawer_item.dart';
import '../../../../utils/ui/models/main_end_drawer_item.dart';

class TimetableViewModel with BaseViewModel {
  late TimetableNotifier timetableNotifier;

  SchoolService schoolService = SchoolService();
  TimetableController? timetableController;
  TimetableFilter? timetableFilter;

  @override
  void init(context) async {
    super.init(context);

    await getFilterDataAndChangeState();
    await getDataAndChangeState();
  }

  setMainEndDrawerItems(TimetableFilter? timetableFilter) {
    timetableNotifier.changeMainEndDrawerItems(
        AppConstants.timetableMainEndDrawerItemTitleKeys.map((e) {
      int index = AppConstants.timetableMainEndDrawerItemTitleKeys.indexOf(e);

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

  Future<TimetableController?> getTimetableControllerByParameters() async {
    int selectedYearIndex = timetableNotifier
        .mainEndDrawerItems[AppConstants.timetableEndDrawerYearIndex]
        .selectedChoosingEndDrawerItemIndex ?? 0;
    int selectedStudentIndex = timetableNotifier
        .mainEndDrawerItems[AppConstants.timetableEndDrawerStudentIndex]
        .selectedChoosingEndDrawerItemIndex ?? 0;
    int selectedMonthIndex = timetableNotifier
        .mainEndDrawerItems[AppConstants.timetableEndDrawerMonthIndex]
        .selectedChoosingEndDrawerItemIndex ?? 0;

    try {
      String? yearId =
          timetableFilter?.schoolYearly?.result?[selectedYearIndex].id;
      String? customerId = timetableFilter
          ?.studentController?.result?[selectedStudentIndex].customer?.id;
      int? monthId = timetableFilter?.months[selectedMonthIndex][Month.ID];

      TimetableController? timetableController = await getTimetableController(
        customerId,
        yearId,
        monthId,
      );

      return timetableController;
    } catch (e) {
      return null;
    }
  }

  List<ChoosingEndDrawerItem>? getChoosingEndDrawerItemsByIndex(
    index,
    TimetableFilter? timetableFilter,
  ) {
    switch (index) {
      case AppConstants.timetableEndDrawerYearIndex:
        return timetableFilter?.schoolYearly?.result!
            .map((e) => ChoosingEndDrawerItem(title: e.info))
            .toList();
      case AppConstants.timetableEndDrawerStudentIndex:
        return timetableFilter?.studentController?.result!
            .map((e) => ChoosingEndDrawerItem(title: e.customer?.fullName))
            .toList();
      case AppConstants.timetableEndDrawerMonthIndex:
        return timetableFilter?.months
            .map((e) => ChoosingEndDrawerItem(title: e[Month.INFO].toString()))
            .toList();
    }
    return null;
  }

  int getSelectedIndexByMainEndDrawerIndex(index) {
    switch (index) {
      case AppConstants.timetableEndDrawerYearIndex:
        return getCurrentYearIndex(timetableFilter?.schoolYearly);
      case AppConstants.timetableEndDrawerMonthIndex:
        int monthIndex = ApiConstants.months.indexWhere(
              (element) => element.containsValue(DateTime.now().month),
        );
        return monthIndex >= 0 ? monthIndex : 0;
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

  int timetableDayListLength() {
    return timetableController?.result?.dates?.length ?? 0;
  }

  Future<void> getDataAndChangeState() async {
    if (!timetableNotifier.isBodyWidgetLoading) {
      timetableNotifier.changeIsBodyWidgetLoading(true);
    }

    await getData().then((value) {
      timetableController = value;
      timetableNotifier.changeIsBodyWidgetLoading(false);
    });
  }

  Future<void> getFilterDataAndChangeState({int? yearIndex}) async {
    if (!timetableNotifier.isChoosingEndDrawerLoading) {
      timetableNotifier.changeIsChoosingEndDrawerLoading(true);
    }

    if (!timetableNotifier.isBodyWidgetLoading) {
      timetableNotifier.changeIsBodyWidgetLoading(true);
    }

    timetableFilter = await getFilterDataByYear(yearIndex: yearIndex);
    setMainEndDrawerItems(timetableFilter);
    timetableNotifier.changeIsChoosingEndDrawerLoading(false);
  }

  Future<TimetableController?> getData() async {
    TimetableController? timetableController =
        await getTimetableControllerByParameters();
    return timetableController;
  }

  /// If [yearIndex] is null year index is current year.
  Future<TimetableFilter> getFilterDataByYear({int? yearIndex}) async {
    YearlyController? schoolYearly = timetableFilter == null
        ? await getYearList()
        : timetableFilter!.schoolYearly;

    //int index = yearIndex ?? getCurrentYearIndex(schoolYearly);

    return TimetableFilter(
      schoolYearly: schoolYearly,
      studentController:
          role == ROLE.ROLE_SCHOOL_STUDENT_PARENT ? await getStudents() : null,
      months: ApiConstants.months,
    );
  }

  Future<YearlyController?> getYearList() async {
    IResponseModel<YearlyController> responseModel =
        await schoolService.fetchYearList(accessToken);

    return responseModel.data;
  }

  Future<StudentController?> getStudents() async {
    IResponseModel<StudentController> responseModel =
        await schoolService.fetchStudents(accessToken);

    return responseModel.data;
  }

  Future<TimetableController?> getTimetableController(
    String? customerId,
    String? yearId,
    int? monthId,
  ) async {
    IResponseModel<TimetableController> responseModel =
        await schoolService.fetchTimetable(
      accessToken,
      customerId,
      yearId,
      monthId,
    );

    return responseModel.data;
  }
}
