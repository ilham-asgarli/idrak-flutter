import 'package:emekteb/core/init/network/IResponseModel.dart';
import 'package:emekteb/data-domain-layer/accounting/modules/invoices_controller.dart';

import '../../../core/constants/api/api_url_constants.dart';
import '../../../core/constants/enums/http_request_enum.dart';
import '../../../core/init/network/core_http.dart';
import '../modules/contract_controller.dart';
import '../modules/customer_controller.dart';
import 'IAccountingService.dart';

class AccountingService extends IAccountingService {
  @override
  Future<IResponseModel<ContractController>> fetchContractListForToken(
      String? accessToken) async {
    IResponseModel<ContractController> response = await CoreHttp.instance.send(
      ApiUrlConstants.contract,
      type: HttpTypes.GET,
      parseModel: ContractController(),
      accessToken: accessToken,
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
