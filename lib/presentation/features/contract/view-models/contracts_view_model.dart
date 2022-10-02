import 'package:emekteb/core/base/view-models/base_view_model.dart';
import 'package:emekteb/data-domain/accounting/modules/contract_controller.dart';
import 'package:emekteb/presentation/features/contract/notifiers/contracts_notifier.dart';

import '../../../../core/init/network/IResponseModel.dart';
import '../../../../data-domain/accounting/modules/pageable_contract_controller.dart';
import '../../../../data-domain/accounting/services/accounting_service.dart';

class ContractsViewModel with BaseViewModel {
  late ContractsNotifier contractsNotifier;

  AccountingService accountingService = AccountingService();
  PageableContractController? pageableContractController;

  @override
  void init(context) async {
    super.init(context);

    await addContractControllersForAdmin(0);
    contractsNotifier.changeIsBodyWidgetLoading(false);
  }

  Future<void> loadMoreData() async {
    int showedListSize = contractsNotifier.contractControllers.length;
    int listSize = pageableContractController?.result?.totalElements ?? 0;

    if (listSize > showedListSize) {
      contractsNotifier.changeIsLoadingMoreData(true);
      int page = (showedListSize / 50).floor();
      await addContractControllersForAdmin(page);
      contractsNotifier.changeIsLoadingMoreData(false);
    }
  }

  Future<void> addContractControllersForAdmin(int page) async {
    pageableContractController = await getContractControllersForAdmin(
      accessToken,
      page,
      50,
    );

    pageableContractController?.result?.content?.forEach((element) {
      contractsNotifier.contractControllers.add(
        ContractController(
          result: [
            element,
          ],
        ),
      );
    });

    contractsNotifier.changeContractControllers(
      List.from(contractsNotifier.contractControllers),
    );
  }

  Future<PageableContractController?> getContractControllersForAdmin(
    String? accessToken,
    int page,
    int size,
  ) async {
    IResponseModel<PageableContractController> responseModel =
        await accountingService.fetchContractListForAdmin(
      accessToken,
      page,
      size,
    );

    return responseModel.data;
  }
}
