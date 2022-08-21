import 'package:emekteb/data-domain-layer/accounting/modules/contract_controller.dart';

class ContractDetails {
  int contractIndex;
  ContractController? contractController;

  ContractDetails({required this.contractIndex, required this.contractController});
}