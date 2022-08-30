import 'package:emekteb/data-domain-layer/accounting/modules/pageable_contract_controller.dart';

import '../../../../../core/init/network/IResponseModel.dart';
import '../modules/contract_controller.dart';
import '../modules/customer_controller.dart';
import '../modules/invoices_controller.dart';

abstract class IAccountingService {
  Future<IResponseModel<ContractController>> fetchContractList(
    String? accessToken,
  );

  Future<IResponseModel<PageableContractController>> fetchContractListForAdmin(
    String? accessToken,
    int page,
    int size,
  );

  Future<IResponseModel<CustomerController>> fetchCustomerByPredimetId(
    String? accessToken,
    String? predimetId,
  );

  Future<IResponseModel<InvoicesController>> fetchInvoicesByContractId(
    String? accessToken,
    String? contractId,
  );
}
