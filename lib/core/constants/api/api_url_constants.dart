class ApiUrlConstants {
  static String base =
      "https://back.idrak.edu.az/";
      //"http://btk.ddns.net:7777/";

  static String auth = "security/auth";
  static String userInfo = "security/user/current";
  static String contacts = "security/chat/contacts";

  static String message(username) => "security/chat/message/$username";

  static String yearly = "school/api/v1/yearly";

  static String yearlyById({required yearId}) => "school/api/v1/yearly/$yearId";

  static String classYearly({required yearId}) =>
      "school/api/v1/class-yearly/year/$yearId";

  static String classYearlyForParent({required yearId, required studentId}) =>
      "school/api/v1/class-yearly/year/$yearId/student/$studentId";

  static String weekYearly({required yearId}) =>
      "school/api/v1/week/year/$yearId";

  static String scheduler({
    required classYearId,
    required weekId,
  }) =>
      "school/api/v1/class-scheduler/classYear/$classYearId/week/$weekId";

  static String timetable({
    required customerId,
    required yearId,
    required int? monthId,
  }) =>
      "school/api/v1/student/timetable/$customerId/$yearId/?month=$monthId";

  static String student = "school/api/v1/student/";

  static String contract = "accounting/api/v1/contract/consent/current";

  static String customerByPredimetId({required predimetId}) =>
      "accounting/api/v1/customer/$predimetId";

  static String contractInvoices({required contractId}) =>
      "accounting/api/v1/contract/invoices/$contractId";
}
