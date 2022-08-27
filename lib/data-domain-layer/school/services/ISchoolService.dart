import 'package:emekteb/data-domain-layer/school/modules/class_yearly_controller.dart';
import 'package:emekteb/data-domain-layer/school/modules/student_controller.dart';
import 'package:emekteb/data-domain-layer/school/modules/week_yearly_controller.dart';
import 'package:emekteb/data-domain-layer/school/modules/yearly_controller.dart';

import '../../../core/init/network/IResponseModel.dart';
import '../modules/scheduler_controller.dart';
import '../modules/timetable_controller.dart';
import '../modules/year_controller.dart';

abstract class ISchoolService {
  Future<IResponseModel<YearlyController>> fetchYearList(
    String? accessToken,
  );

  Future<IResponseModel<YearController>> fetchYearByYearId(
    String? accessToken,
    String? yearId,
  );

  Future<IResponseModel<ClassYearlyController>> fetchClassList(
    String? accessToken,
    String? yearId,
  );

  Future<IResponseModel<ClassYearlyController>> fetchClassListForParent(
    String? accessToken,
    String? yearId,
    String? studentId,
  );

  Future<IResponseModel<WeekYearlyController>> fetchWeekList(
    String? accessToken,
    String? yearId,
  );

  Future<IResponseModel<SchedulerController>> fetchScheduler(
    String? accessToken,
    String? classYearId,
    String? weekId,
  );

  Future<IResponseModel<TimetableController>> fetchTimetable(
    String? accessToken,
    String? customerId,
    String? yearId,
    int? monthId,
  );

  Future<IResponseModel<StudentController>> fetchStudents(
    String? accessToken,
  );
}
