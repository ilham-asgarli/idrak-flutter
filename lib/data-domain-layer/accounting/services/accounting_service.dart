import 'package:emekteb/core/init/network/IResponseModel.dart';
import 'package:emekteb/data-domain-layer/accounting/modules/invoices_controller.dart';
import 'package:emekteb/data-domain-layer/accounting/modules/pageable_contract_controller.dart';

import '../../../core/constants/api/api_url_constants.dart';
import '../../../core/constants/enums/http_request_enum.dart';
import '../../../core/init/network/core_http.dart';
import '../modules/contract_controller.dart';
import '../modules/customer_controller.dart';
import 'IAccountingService.dart';

class AccountingService extends IAccountingService {
  @override
  Future<IResponseModel<ContractController>> fetchContractList(
    String? accessToken,
  ) async {
    IResponseModel<ContractController> response = await CoreHttp.instance.send(
      ApiUrlConstants.contract,
      type: HttpTypes.GET,
      parseModel: ContractController(),
      accessToken: accessToken,
    );

    return response;
  }

  @override
  Future<IResponseModel<PageableContractController>> fetchContractListForAdmin(
    String? accessToken,
    int page,
    int size,
  ) async {
    IResponseModel<PageableContractController> response =
        await CoreHttp.instance.send(
      ApiUrlConstants.contractsForAdmin(page, size),
      type: HttpTypes.POST,
      parseModel: PageableContractController(),
      accessToken: accessToken,
      data: {
        "criteria": [
          {"key": "id", "operation": "IS_NOT_NULL", "value": ""}
        ]
      },
    );

    return response;
  }

  @override
  Future<IResponseModel<CustomerController>> fetchCustomerByPredimetId(
      String? accessToken, String? predimetId) async {
    IResponseModel<CustomerController> response = await CoreHttp.instance.send(
      ApiUrlConstants.customerByPredimetId(predimetId: predimetId),
      type: HttpTypes.GET,
      parseModel: CustomerController(),
      accessToken: accessToken,
    );

    return response;
  }

  @override
  Future<IResponseModel<InvoicesController>> fetchInvoicesByContractId(
      String? accessToken, String? contractId) async {
    IResponseModel<InvoicesController> response = await CoreHttp.instance.send(
      ApiUrlConstants.contractInvoices(contractId: contractId),
      type: HttpTypes.GET,
      parseModel: InvoicesController(),
      accessToken: accessToken,
    );

    return response;
  }
}
