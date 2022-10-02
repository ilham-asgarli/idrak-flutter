import 'package:emekteb/data-domain/school/modules/student_controller.dart';
import 'package:emekteb/data-domain/school/modules/week_yearly_controller.dart';
import 'package:emekteb/data-domain/school/modules/yearly_controller.dart';

import '../../../../data-domain/school/modules/class_yearly_controller.dart';

class ScheduleFilter {
  YearlyController? schoolYearly;
  StudentController? studentController;
  ClassYearlyController? schoolClassYearly;
  WeekYearlyController? schoolWeekYearly;

  ScheduleFilter({
    required this.schoolYearly,
    required this.studentController,
    required this.schoolClassYearly,
    required this.schoolWeekYearly,
  });
}
