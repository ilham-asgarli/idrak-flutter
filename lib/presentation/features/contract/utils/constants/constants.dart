import '../../../../../../generated/locale_keys.g.dart';

class Constants {
  static const List<String> contractConditionItemNames = [
    LocaleKeys.contract_contractNumber,
    LocaleKeys.contract_contractType_info,
    LocaleKeys.contract_contractDate,
    LocaleKeys.contract_expireDate,
    LocaleKeys.contract_contractPaymentOrder_totalValue,
    LocaleKeys.contract_contractPaymentOrder_discount,
    LocaleKeys.contract_contractPaymentOrder_totalAmount,
    LocaleKeys.contract_contractPaymentOrder_paymentType_info,
    LocaleKeys.contract_contractPaymentOrder_offerMonth,
    LocaleKeys.contract_contractPaymentOrder_monthlyPayment,
    LocaleKeys.contract_contractPaymentOrder_discountMonth,
    LocaleKeys.contract_contractPaymentOrder_loanPercent,
    LocaleKeys.contract_contractPaymentOrder_offerDate,
    LocaleKeys.contract_contractPaymentOrder_offerEndDate,
    LocaleKeys.contract_contractPaymentOrder_initialAmount,
    LocaleKeys.contract_contractPaymentOrder_totalPaymentAmount,
    LocaleKeys.contract_contractPaymentOrder_totalDeptAmount,
  ];

  static const List<String> contractCustomerItemNames = [
    LocaleKeys.contractParent_fullName,
    LocaleKeys.contractParent_documentSerial,
    LocaleKeys.contractParent_documentFin,
    LocaleKeys.contractParent_documentOrganisation,
  ];

  static const List<String> contractStudentItemNames = [
    LocaleKeys.contractStudent_fullName,
    LocaleKeys.contractStudent_year,
    LocaleKeys.contractStudent_documentSerial,
    LocaleKeys.contractStudent_class,
    LocaleKeys.contractStudent_organisationCode,
    LocaleKeys.contractStudent_documentFin
  ];

  static const List<String> contractPaymentDetailNames = [
    LocaleKeys.contract_contractPaymentOrderLine_line,
    LocaleKeys.contract_contractPaymentOrderLine_lineDate,
    LocaleKeys.contract_contractPaymentOrderLine_amount,
    LocaleKeys.contract_contractPaymentOrderLine_debt,
  ];

  static const List<String> contractPaymentPortionDetailNames = [
    LocaleKeys.contract_contractPaymentOrderLine_payments_paymentDate,
    LocaleKeys.contract_contractPaymentOrderLine_payments_lineAmount,
  ];

  static const List<String> contractPaymentNames = [
    LocaleKeys.contractInvoices_no,
    LocaleKeys.contractInvoices_qaimeNo,
    LocaleKeys.contractInvoices_amount,
    LocaleKeys.contractInvoices_currency,
    LocaleKeys.contractInvoices_account,
    LocaleKeys.contractInvoices_date,
  ];
}
