import 'package:emekteb/data-domain/school/modules/yearly_controller.dart';

import '../../../../utils/app/constants/enums/api_enum.dart';
import '../../../../data-domain/school/modules/student_controller.dart';


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
