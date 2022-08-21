import 'package:emekteb/data-domain-layer/school/modules/school_week_yearly.dart';
import 'package:emekteb/data-domain-layer/school/modules/school_yearly.dart';

import '../../../../data-domain-layer/school/modules/school_class_yearly.dart';

class TimetableFilter {
  SchoolYearsController? schoolYearly;
  SchoolClassYearly? schoolClassYearly;
  SchoolWeekYearly? schoolWeekYearly;

  TimetableFilter({
    required this.schoolYearly,
    required this.schoolClassYearly,
    required this.schoolWeekYearly,
  });
}
