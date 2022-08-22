import 'package:emekteb/core/init/network/IResponseModel.dart';
import 'package:emekteb/data-domain-layer/school/modules/school_year_controller.dart';
import 'package:emekteb/data-domain-layer/school/modules/school_week_yearly.dart';
import 'package:emekteb/data-domain-layer/school/modules/school_yearly.dart';

import '../../../core/constants/app/api_constants.dart';
import '../../../core/constants/enums/http_request_enum.dart';
import '../../../core/init/network/core_http.dart';
import '../modules/school_scheduler.dart';
import '../modules/school_class_yearly.dart';
import 'ISchoolService.dart';

class SchoolService extends ISchoolService {
  @override
  Future<IResponseModel<SchoolYearsController>> fetchYearList(accessToken) async {
    IResponseModel<SchoolYearsController> response = await CoreHttp.instance.send(
      ApiConstants.yearly,
      type: HttpTypes.GET,
      parseModel: SchoolYearsController(),
      accessToken: accessToken,
    );

    return response;
  }

  @override
  Future<IResponseModel<SchoolClassYearly>> fetchClassList(
      String? accessToken, String? yearId) async {
    String url = ApiConstants.classYearly(yearId: yearId);

    IResponseModel<SchoolClassYearly> response = await CoreHttp.instance.send(
      url,
      type: HttpTypes.GET,
      parseModel: SchoolClassYearly(),
      accessToken: accessToken,
    );

    return response;
  }

  @override
  Future<IResponseModel<SchoolWeekYearly>> fetchWeekList(
      String? accessToken, String? yearId) async {
    String url = ApiConstants.weekYearly(yearId: yearId);

    IResponseModel<SchoolWeekYearly> response = await CoreHttp.instance.send(
      url,
      type: HttpTypes.GET,
      parseModel: SchoolWeekYearly(),
      accessToken: accessToken,
    );

    return response;
  }

  @override
  Future<IResponseModel<SchoolScheduler>> fetchScheduler(
      String? accessToken, String? classYearId, String? weekId) async {
    String url = ApiConstants.scheduler(classYearId: classYearId, weekId: weekId);

    IResponseModel<SchoolScheduler> response = await CoreHttp.instance.send(
      url,
      type: HttpTypes.GET,
      parseModel: SchoolScheduler(),
      accessToken: accessToken,
    );

    return response;
  }

  @override
  Future<IResponseModel<SchoolYearController>> fetchYearByYearId(String? accessToken, String? yearId) async {
    String url = ApiConstants.yearlyById(yearId: yearId);

    IResponseModel<SchoolYearController> response = await CoreHttp.instance.send(
      url,
      type: HttpTypes.GET,
      parseModel: SchoolYearController(),
      accessToken: accessToken,
    );

    return response;
  }
}
