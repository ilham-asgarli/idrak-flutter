class ApiConstants {
  static String base = "https://back.idrak.edu.az/";

  static String auth = "security/auth";
  static String userInfo = "security/user/current";

  static String yearly = "school/api/v1/yearly";
  static String yearlyById(yearId) => "school/api/v1/yearly/$yearId";
  static String classYearly(yearId) => "school/api/v1/class-yearly/year/$yearId";
  static String weekYearly(yearId) => "school/api/v1/week/year/$yearId";
  static String scheduler(classYearId, weekId) => "school/api/v1/class-scheduler/classYear/$classYearId/week/$weekId";

  static String contract = "accounting/api/v1/contract/consent/current";
  static String customerByPredimetId(predimetId) => "accounting/api/v1/customer/$predimetId";
}