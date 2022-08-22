import 'package:easy_localization/easy_localization.dart';
import 'package:emekteb/core/base/view-models/base_view_model.dart';
import 'package:emekteb/data-domain-layer/accounting/modules/customer_controller.dart';
import 'package:emekteb/data-domain-layer/school/modules/school_year_controller.dart';
import 'package:emekteb/data-domain-layer/school/services/school_service.dart';
import 'package:emekteb/utils/constants/app/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../../core/init/network/IResponseModel.dart';
import '../../../../data-domain-layer/accounting/services/accounting_service.dart';
import '../../../../data-domain-layer/accounting/modules/contract_controller.dart';
import '../../../../generated/locale_keys.g.dart';
import '../notifiers/contract_notifier.dart';

class ContractViewModel with BaseViewModel {
  late ContractNotifier contractNotifier;

  ContractController? contractController;
  List<CustomerController?> customerControllers = [];
  List<SchoolYearController?> schoolYearControllers = [];

  AccountingService accountingService = AccountingService();
  SchoolService schoolService = SchoolService();

  @override
  void init(context) async {
    super.init(context);

    contractNotifier = Provider.of<ContractNotifier>(context);
    contractNotifier.reset();

    contractController = await getContractController(accessToken);

    if (contractController?.result != null) {
      for (var contract in contractController!.result!) {
        customerControllers.add(await getCustomerController(
            accessToken, contract.contractPredimet?.predimetId));
      }
    }

    if (contractController?.result != null) {
      for (var contract in contractController!.result!) {
        String? yearId;
        contract.contractPredimet?.parametrs?.forEach((element) {
          if (element.indeks == "yearId") {
            yearId = element.value;
          }
        });
        schoolYearControllers
            .add(await getSchoolYearController(accessToken, yearId));
      }
    }

    setContractItems();
    setCustomerItems();
    setStudentItems();

    contractNotifier.changeIsMainDataLoading(false);
  }

  int contractListLength() {
    return contractController?.result?.length ?? 0;
  }

  bool isCustomerHaveContract() {
    return contractController?.result?.length != null &&
        contractController!.result!.isNotEmpty;
  }

  Future<ContractController?> getContractController(String? accessToken) async {
    IResponseModel<ContractController> responseModel =
        await accountingService.fetchContractListForToken(accessToken);

    return responseModel.data;
  }

  Future<CustomerController?> getCustomerController(
      String? accessToken, String? predimetId) async {
    IResponseModel<CustomerController> responseModel = await accountingService
        .fetchCustomerByPredimetId(accessToken, predimetId);

    return responseModel.data;
  }

  Future<SchoolYearController?> getSchoolYearController(
      String? accessToken, String? yearId) async {
    IResponseModel<SchoolYearController> responseModel =
        await schoolService.fetchYearByYearId(accessToken, yearId);

    return responseModel.data;
  }

  setContractItems() {
    if (contractController?.result != null) {
      List<Map<String, String>> list = contractController!.result!.map((e) {
        int index = contractController!.result!.indexOf(e);
        return {
          for (String contractItemName in AppConstants.contractConditionItemNames)
            contractItemName.tr():
                getContractConditionDetailByName(contractItemName, index),
        };
      }).toList();

      contractNotifier.changeContractItems(list);
    }
  }

  setCustomerItems() {
    if (contractController?.result != null) {
      List<Map<String, String>> list = contractController!.result!.map((e) {
        int index = contractController!.result!.indexOf(e);
        return {
          for (String customerItemName in AppConstants.contractCustomerItemNames)
            customerItemName.tr():
                getCustomerInfoDetailByName(customerItemName, index),
        };
      }).toList();

      contractNotifier.changeCustomerItems(list);
    }
  }

  setStudentItems() {
    if (contractController?.result != null) {
      List<Map<String, String>> list = contractController!.result!.map((e) {
        int index = contractController!.result!.indexOf(e);
        return {
          for (String studentItemName in AppConstants.contractStudentItemNames)
            studentItemName.tr():
                getStudentInfoDetailByName(studentItemName, index),
        };
      }).toList();

      contractNotifier.changeStudentItems(list);
    }
  }

  String getContractConditionDetailByName(String contractItemName, int index) {
    String? detail;

    switch (contractItemName) {
      case LocaleKeys.contract_contractNumber:
        detail = contractController?.result?[index].contractNumber;
        break;
      case LocaleKeys.contract_contractType_info:
        detail = contractController?.result?[index].contractType?.info;
        break;
      case LocaleKeys.contract_contractDate:
        detail = contractController?.result?[index].contractDate;
        break;
      case LocaleKeys.contract_expireDate:
        detail =
            contractController?.result?[index].contractPaymentOrder?.expireDate;
        break;
      case LocaleKeys.contract_contractPaymentOrder_totalValue:
        detail = contractController
            ?.result?[index].contractPaymentOrder?.totalValue
            .toString();
        break;
      case LocaleKeys.contract_contractPaymentOrder_discount:
        detail = contractController
            ?.result?[index].contractPaymentOrder?.discount
            .toString();
        break;
      case LocaleKeys.contract_contractPaymentOrder_totalAmount:
        detail = contractController
            ?.result?[index].contractPaymentOrder?.totalAmount
            .toString();
        break;
      case LocaleKeys.contract_contractPaymentOrder_paymentType_info:
        detail = contractController
            ?.result?[index].contractPaymentOrder?.paymentType?.info;
        break;
      case LocaleKeys.contract_contractPaymentOrder_offerMonth:
        detail = contractController
            ?.result?[index].contractPaymentOrder?.offerMonth
            .toString();
        break;
      case LocaleKeys.contract_contractPaymentOrder_monthlyPayment:
        detail = contractController
            ?.result?[index].contractPaymentOrder?.monthlyPayment
            .toString();
        break;
      case LocaleKeys.contract_contractPaymentOrder_discountMonth:
        detail = contractController
            ?.result?[index].contractPaymentOrder?.discountMonth
            .toString();
        break;
      case LocaleKeys.contract_contractPaymentOrder_loanPercent:
        detail = contractController
            ?.result?[index].contractPaymentOrder?.loanPercent
            .toString();
        break;
      case LocaleKeys.contract_contractPaymentOrder_offerDate:
        detail =
            contractController?.result?[index].contractPaymentOrder?.offerDate;
        break;
      case LocaleKeys.contract_contractPaymentOrder_offerEndDate:
        detail = contractController
            ?.result?[index].contractPaymentOrder?.offerEndDate;
        break;
      case LocaleKeys.contract_contractPaymentOrder_initialAmount:
        detail =
            "${contractController?.result?[index].contractPaymentOrder?.initialAmount.toString()} (${contractController?.result?[index].contractPaymentOrder?.initialAmountPercent.toString()}%)";
        break;
      case LocaleKeys.contract_contractPaymentOrder_totalPaymentAmount:
        detail =
            "${contractController?.result?[index].contractPaymentOrder?.totalPaymentAmount.toString()} (${contractController?.result?[index].contractPaymentOrder?.totalPaymentPercent.toString()}%)";
        break;
      case LocaleKeys.contract_contractPaymentOrder_totalDeptAmount:
        detail =
            "${contractController?.result?[index].contractPaymentOrder?.totalDeptAmount.toString()} (${contractController?.result?[index].contractPaymentOrder?.totalDeptPercent.toString()}%)";
        break;
    }

    return detail ?? "";
  }

  String getCustomerInfoDetailByName(String itemName, int index) {
    String? detail;

    switch (itemName) {
      case LocaleKeys.contractParent_fullName:
        detail = contractController
            ?.result?[index].agreementSide?.customer?.fullName;
        break;
      case LocaleKeys.contractParent_documentSerial:
        detail = contractController?.result?[index].agreementSide?.customer
            ?.customerDocument?.documentSeriya;
        break;
      case LocaleKeys.contractParent_documentFin:
        detail = contractController?.result?[index].agreementSide?.customer
            ?.customerDocument?.documentFin;
        break;
      case LocaleKeys.contractParent_documentOrganisation:
        detail = contractController?.result?[index].agreementSide?.customer
            ?.customerDocument?.documentOrqan;
        break;
    }

    return detail ?? "";
  }

  //TODO: get class detail from api
  String getStudentInfoDetailByName(String contractItemName, int index) {
    String? detail;

    switch (contractItemName) {
      case LocaleKeys.contractStudent_fullName:
        detail = customerControllers[index]?.result?.fullName;
        break;
      case LocaleKeys.contractStudent_year:
        detail = schoolYearControllers[index]?.result?.info;
        break;
      case LocaleKeys.contractStudent_documentSerial:
        detail = customerControllers[index]
            ?.result
            ?.customerDocument
            ?.documentSeriya;
        break;
      case LocaleKeys.contractStudent_class:
        detail = "5 R2";
        break;
      case LocaleKeys.contractStudent_organisationCode:
        detail =
            customerControllers[index]?.result?.customerDocument?.documentOrqan;
        break;
      case LocaleKeys.contractStudent_documentFin:
        detail =
            customerControllers[index]?.result?.customerDocument?.documentFin;
        break;
    }

    return detail ?? "";
  }
}
