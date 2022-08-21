import 'package:emekteb/data-domain-layer/school/modules/school_class_yearly.dart';
import 'package:emekteb/data-domain-layer/school/modules/school_week_yearly.dart';
import 'package:emekteb/data-domain-layer/school/modules/school_yearly.dart';

import '../../../core/init/network/IResponseModel.dart';
import '../modules/school_scheduler.dart';
import '../modules/school_year_controller.dart';

abstract class ISchoolService {
  Future<IResponseModel<SchoolYearsController>> fetchYearList(String? accessToken);
  Future<IResponseModel<SchoolYearController>> fetchYearByYearId(String? accessToken, String? yearId);
  Future<IResponseModel<SchoolClassYearly>> fetchClassList(String? accessToken, String? yearId);
  Future<IResponseModel<SchoolWeekYearly>> fetchWeekList(String? accessToken, String? yearId);
  Future<IResponseModel<SchoolScheduler>> fetchScheduler(String? accessToken, String? classYearId, String? weekId);
}
