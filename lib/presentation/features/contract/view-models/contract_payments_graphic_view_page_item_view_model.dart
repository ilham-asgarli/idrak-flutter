import 'package:easy_localization/easy_localization.dart';
import 'package:emekteb/core/base/view-models/base_view_model.dart';
import 'package:emekteb/generated/locale_keys.g.dart';
import 'package:emekteb/utils/ui/constants/app/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../../data-domain/accounting/modules/contract_controller.dart';
import '../models/contract_details.dart';
import '../notifiers/contract_payments_graphic_view_page_item_notifier.dart';

class ContractPaymentsGraphicViewPageItemViewModel with BaseViewModel {
  late ContractPaymentsGraphicViewPageItemNotifier notifier;
  late ContractDetails contractDetails;
  late int index;

  @override
  void init(context) {
    super.init(context);

    notifier =
        Provider.of<ContractPaymentsGraphicViewPageItemNotifier>(context);
    notifier.reset();
  }

  int getPaymentsListLength() {
    return contractDetails
            .contractController
            ?.result?[contractDetails.contractIndex]
            .contractPaymentOrder
            ?.contractPaymentOrderLine?[index]
            .payments
            ?.length ??
        0;
  }

  Map<String?, String?> getContractPaymentDetailsMap() {
    return {
      for (String s in AppConstants.contractPaymentDetailNames)
        s.tr(): getContractPaymentDetailsValueByName(s)
    };
  }

  List<Map<String?, String?>> getContractPaymentPortionDetailsMapList() {
    List<Map<String?, String?>> list = [];

    List<Payments>? payments = contractDetails
            .contractController
            ?.result?[contractDetails.contractIndex]
            .contractPaymentOrder
            ?.contractPaymentOrderLine?[index]
            .payments ??
        [];

    for (var element in payments) {
      int paymentIndex = payments.indexOf(element);
      list.add({
        for (String s in AppConstants.contractPaymentPortionDetailNames)
          s.tr(): getContractPaymentPortionDetailsValueByName(s, paymentIndex)
      });
    }

    return list;
  }

  String? getContractPaymentDetailsValueByName(String name) {
    String? detail;
    ContractPaymentOrderLine? contractPaymentOrderLine = contractDetails
        .contractController
        ?.result?[contractDetails.contractIndex]
        .contractPaymentOrder
        ?.contractPaymentOrderLine?[index];

    switch (name) {
      case LocaleKeys.contract_contractPaymentOrderLine_line:
        detail = "${contractPaymentOrderLine?.line ?? ""}";
        break;
      case LocaleKeys.contract_contractPaymentOrderLine_lineDate:
        detail = contractPaymentOrderLine?.lineDate;
        break;
      case LocaleKeys.contract_contractPaymentOrderLine_amount:
        detail = "${contractPaymentOrderLine?.amount ?? ""}";
        break;
      case LocaleKeys.contract_contractPaymentOrderLine_debt:
        detail = "${contractPaymentOrderLine?.debt ?? ""}";
        break;
    }

    return detail ?? "";
  }

  String? getContractPaymentPortionDetailsValueByName(
      String name, int paymentIndex) {
    String? detail;
    ContractPaymentOrderLine? contractPaymentOrderLine = contractDetails
        .contractController
        ?.result?[contractDetails.contractIndex]
        .contractPaymentOrder
        ?.contractPaymentOrderLine?[index];

    switch (name) {
      case LocaleKeys.contract_contractPaymentOrderLine_payments_paymentDate:
        detail = contractPaymentOrderLine?.payments?[paymentIndex].paymentDate;
        break;
      case LocaleKeys.contract_contractPaymentOrderLine_payments_lineAmount:
        detail =
            "${contractPaymentOrderLine?.payments?[paymentIndex].lineAmount ?? ""}";
        break;
    }

    return detail ?? "";
  }
}
