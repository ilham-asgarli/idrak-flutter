import 'package:easy_localization/easy_localization.dart';
import 'package:emekteb/core/base/view-models/base_view_model.dart';

import '../../../../generated/locale_keys.g.dart';
import '../constants/constants.dart';
import '../models/contract_payment_details.dart';

class ContractPaymentsViewPageItemViewModel with BaseViewModel {
  late ContractPaymentDetails contractPaymentDetails;

  getContractPaymentMap() {
    return {
      for (String s in Constants.contractPaymentNames)
        getContractPaymentKeyByName(s): getContractPaymentValueByName(s)
    };
  }

  String? getContractPaymentKeyByName(String name) {
    if (name == LocaleKeys.contractInvoices_account) {
      return contractPaymentDetails
                  .invoicesController
                  ?.result?[contractPaymentDetails.contractPaymentIndex]
                  .kassa !=
              null
          ? name.tr(gender: "cash")
          : name.tr(gender: "bank");
    }

    return name.tr();
  }

  String? getContractPaymentValueByName(String name) {
    String? detail;

    switch (name) {
      case LocaleKeys.contractInvoices_no:
        detail = "${contractPaymentDetails.contractPaymentIndex + 1}";
        break;
      case LocaleKeys.contractInvoices_qaimeNo:
        detail =
            "${contractPaymentDetails.invoicesController?.result?[contractPaymentDetails.contractPaymentIndex].paymentNumber ?? ""}";
        break;
      case LocaleKeys.contractInvoices_amount:
        detail =
            "${contractPaymentDetails.invoicesController?.result?[contractPaymentDetails.contractPaymentIndex].amount ?? ""}";
        break;
      case LocaleKeys.contractInvoices_currency:
        detail = contractPaymentDetails
            .invoicesController
            ?.result?[contractPaymentDetails.contractPaymentIndex]
            .currency
            ?.isoCode;
        break;
      case LocaleKeys.contractInvoices_account:
        if (contractPaymentDetails.invoicesController
                ?.result?[contractPaymentDetails.contractPaymentIndex].kassa !=
            null) {
          detail = contractPaymentDetails
              .invoicesController
              ?.result?[contractPaymentDetails.contractPaymentIndex]
              .kassa
              ?.info;
        } else if (contractPaymentDetails
                .invoicesController
                ?.result?[contractPaymentDetails.contractPaymentIndex]
                .bankAccount !=
            null) {
          detail =
              "${contractPaymentDetails.invoicesController?.result?[contractPaymentDetails.contractPaymentIndex].bankAccount?.bank?.info} ${contractPaymentDetails.invoicesController?.result?[contractPaymentDetails.contractPaymentIndex].bankAccount?.bankAccount}";
        }
        break;
      case LocaleKeys.contractInvoices_date:
        detail = contractPaymentDetails.invoicesController
            ?.result?[contractPaymentDetails.contractPaymentIndex].paymentDate;
        break;
    }

    return detail ?? "";
  }
}
