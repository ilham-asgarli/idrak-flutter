import 'package:emekteb/data-domain-layer/school/modules/week_yearly_controller.dart';
import 'package:emekteb/data-domain-layer/school/modules/yearly_controller.dart';

import '../../../../data-domain-layer/school/modules/class_yearly_controller.dart';

class TimetableFilter {
  YearlyController? schoolYearly;
  ClassYearlyController? schoolClassYearly;
  WeekYearlyController? schoolWeekYearly;

  TimetableFilter({
    required this.schoolYearly,
    required this.schoolClassYearly,
    required this.schoolWeekYearly,
  });
}
