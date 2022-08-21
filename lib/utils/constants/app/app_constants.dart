import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../presentation-layer/features/home/models/home_menu_item.dart';

class AppConstants {
  static final List<HomeMenuItem> allMenuItems = [
    HomeMenuItem(
        route: NavigationConstants.TIMETABLE,
        iconData: FontAwesomeIcons.list,
        iconColor: Colors.orange),
    HomeMenuItem(
        route: NavigationConstants.DIARY,
        iconData: FontAwesomeIcons.book,
        iconColor: Colors.teal),
    HomeMenuItem(
        route: NavigationConstants.CHAT,
        iconData: FontAwesomeIcons.rocketchat,
        iconColor: Colors.green),
    HomeMenuItem(
        route: NavigationConstants.CONTRACT,
        iconData: FontAwesomeIcons.handshake,
        iconColor: Colors.blue),
  ];

  static const int timetableEndDrawerYearIndex = 0;
  static const int timetableEndDrawerWeekIndex = 1;
  static const int timetableEndDrawerClassIndex = 2;

  static const List<String> mainEndDrawerItemTitleKeys = [
    LocaleKeys.mainEndDrawerItemTitles_0,
    LocaleKeys.mainEndDrawerItemTitles_1,
    LocaleKeys.mainEndDrawerItemTitles_2,
  ];

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
    LocaleKeys.contract_contractPaymentOrderLine_discountPercent,
    LocaleKeys.contract_contractPaymentOrderLine_mustPay,
    LocaleKeys.contract_contractPaymentOrderLine_debt,
  ];

  static const List<String> contractPaymentPortionDetailNames = [
    LocaleKeys.contract_contractPaymentOrderLine_payments_paymentDate,
    LocaleKeys.contract_contractPaymentOrderLine_payments_lineAmount,
  ];
}
