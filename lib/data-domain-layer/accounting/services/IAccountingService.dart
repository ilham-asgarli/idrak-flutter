import '../../../../../core/init/network/IResponseModel.dart';
import '../modules/contract_controller.dart';
import '../modules/customer_controller.dart';

abstract class IAccountingService {
  Future<IResponseModel<ContractController>> fetchContractListForToken(String? accessToken);
  Future<IResponseModel<CustomerController>> fetchCustomerByPredimetId(String? accessToken, String predimetId);
}
