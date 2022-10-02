import 'package:emekteb/core/base/notifiers/base_change_notifier.dart';
import 'package:emekteb/data-domain/accounting/modules/contract_controller.dart';

class ContractsNotifier extends BaseChangeNotifier {
  List<ContractController?> contractControllers = [];
  bool isBodyWidgetLoading = true;
  bool isLoadingMoreData = false;

  changeContractControllers(
    List<ContractController?> contractControllers,
  ) {
    this.contractControllers = contractControllers;
    notifyListeners();
  }

  changeIsBodyWidgetLoading(bool isBodyWidgetLoading) {
    this.isBodyWidgetLoading = isBodyWidgetLoading;
    notifyListeners();
  }

  changeIsLoadingMoreData(bool isLoadingMoreData) {
    this.isLoadingMoreData = isLoadingMoreData;
    notifyListeners();
  }
}
