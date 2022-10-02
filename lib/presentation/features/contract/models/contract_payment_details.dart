import 'package:emekteb/data-domain/accounting/modules/invoices_controller.dart';
import 'package:emekteb/presentation/features/contract/models/contract_details.dart';

class ContractPaymentDetails {
  ContractDetails? contractDetails;
  InvoicesController? invoicesController;
  int contractPaymentIndex;

  ContractPaymentDetails({
    required this.contractDetails,
    required this.invoicesController,
    required this.contractPaymentIndex,
  });
}