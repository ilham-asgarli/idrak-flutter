import 'package:emekteb/core/base/view-models/base_view_model.dart';
import 'package:emekteb/data-domain-layer/accounting/modules/invoices_controller.dart';
import 'package:provider/provider.dart';

import '../../../../core/init/network/IResponseModel.dart';
import '../../../../data-domain-layer/accounting/services/accounting_service.dart';
import '../models/contract_details.dart';
import '../notifiers/contract_payments_notifier.dart';

class ContractPaymentsViewModel with BaseViewModel {
  AccountingService accountingService = AccountingService();

  late ContractPaymentsNotifier contractPaymentsNotifier;
  ContractDetails? contractDetails;
  InvoicesController? invoicesController;

  @override
  void init(context) async {
    super.init(context);

    contractPaymentsNotifier = Provider.of<ContractPaymentsNotifier>(context);
    contractPaymentsNotifier.reset();

    invoicesController = await getInvoicesController(
      accessToken,
      contractDetails
          ?.contractController?.result?[contractDetails?.contractIndex ?? 0].id,
    );

    contractPaymentsNotifier.changeIsMainLoading(false);
  }

  int getPaymentListLength() {
    return invoicesController?.result?.length ?? 0;
  }

  Future<InvoicesController?> getInvoicesController(
      String? accessToken, String? contractId) async {
    IResponseModel<InvoicesController> responseModel = await accountingService
        .fetchInvoicesByContractId(accessToken, contractId);

    return responseModel.data;
  }
}
