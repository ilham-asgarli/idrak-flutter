import 'package:emekteb/data-domain-layer/school/modules/yearly_controller.dart';

import '../../../../core/constants/enums/api_enum.dart';
import '../../../../data-domain-layer/school/modules/student_controller.dart';


class TimetableFilter {
  StudentController? studentController;
  YearlyController? schoolYearly;
  List<Map<Month, dynamic>> months;

  TimetableFilter({
    required this.studentController,
    required this.schoolYearly,
    required this.months,
  });
}
