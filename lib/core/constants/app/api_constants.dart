class ApiConstants {
  static String base = "https://back.idrak.edu.az/"; // "http://btk.ddns.net:7777/";

  static String auth = "security/auth";
  static String userInfo = "security/user/current";

  static String yearly = "school/api/v1/yearly";
  static String yearlyById({required yearId}) => "school/api/v1/yearly/$yearId";
  static String classYearly({required yearId}) => "school/api/v1/class-yearly/year/$yearId";
  static String weekYearly({required yearId}) => "school/api/v1/week/year/$yearId";
  static String scheduler({required classYearId, required weekId}) => "school/api/v1/class-scheduler/classYear/$classYearId/week/$weekId";

  static String contract = "accounting/api/v1/contract/consent/current";
  static String customerByPredimetId({required predimetId}) => "accounting/api/v1/customer/$predimetId";
  static String contractInvoices({required contractId}) => "accounting/api/v1/contract/invoices/$contractId";
}