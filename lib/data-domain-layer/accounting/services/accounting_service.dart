import 'package:emekteb/core/init/network/IResponseModel.dart';

import '../../../core/constants/app/api_constants.dart';
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
      ApiConstants.contract,
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
      ApiConstants.customerByPredimetId(predimetId),
      type: HttpTypes.GET,
      parseModel: CustomerController(),
      accessToken: accessToken,
    );

    return response;
  }
}
