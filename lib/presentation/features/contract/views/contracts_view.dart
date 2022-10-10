import 'package:emekteb/utils/app/constants/navigation/navigation_constants.dart';
import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/core/init/navigation/navigation_service.dart';
import 'package:emekteb/data-domain/accounting/modules/contract_controller.dart';
import 'package:emekteb/presentation/features/contract/models/contract_model.dart';
import 'package:emekteb/presentation/features/contract/notifiers/contracts_notifier.dart';
import 'package:emekteb/presentation/features/contract/view-models/contracts_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/views/base_view.dart';
import '../components/contracts_view_placeholder.dart';

class ContractsView extends StatefulWidget {
  final String title;

  const ContractsView({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  State<ContractsView> createState() => _ContractsViewState();
}

class _ContractsViewState extends State<ContractsView> {
  late ContractsViewModel _contractsViewModel;

  @override
  void dispose() {
    _contractsViewModel.contractsNotifier.isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ContractsNotifier(),
        ),
        Consumer<ContractsNotifier>(builder: (context, notifier, _) {
          return BaseView<ContractsViewModel>(
            viewModel: ContractsViewModel(),
            onModelReady: (model) async {
              _contractsViewModel = model;
              _contractsViewModel.contractsNotifier = notifier;
              model.init(context);
            },
            onPageBuilder:
                (BuildContext buildContext, ContractsViewModel model) =>
                    buildPage(),
          );
        }),
      ],
    );
  }

  Widget buildPage() {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return _contractsViewModel.contractsNotifier.isBodyWidgetLoading
        ? const ContractsViewPlaceholder()
        : buildMainBody();
  }

  Widget buildMainBody() {
    return LazyLoadScrollView(
      scrollOffset: context.height.toInt(),
      isLoading: _contractsViewModel.contractsNotifier.isLoadingMoreData,
      onEndOfPage: () => _contractsViewModel.loadMoreData(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              padding: context.paddingLow,
              cacheExtent: 1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _contractsViewModel
                  .contractsNotifier.contractControllers.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      "${index + 1}. ${_contractsViewModel.contractsNotifier.contractControllers[index]?.result?[0].agreementSide?.customer?.fullName ?? ""}",
                    ),
                    subtitle: Text(
                      _contractsViewModel
                              .contractsNotifier
                              .contractControllers[index]
                              ?.result?[0]
                              .contractNumber ??
                          "",
                    ),
                    trailing: Text(
                      _contractsViewModel
                              .contractsNotifier
                              .contractControllers[index]
                              ?.result?[0]
                              .contractDate ??
                          "",
                    ),
                    onTap: () {
                      NavigationService.instance.navigateToPage(
                        path: NavigationConstants.CONTRACTS,
                        data: ContractModel(
                          contractController: ContractController(
                            result: _contractsViewModel.contractsNotifier
                                .contractControllers[index]?.result,
                          ),
                          title: widget.title, //LocaleKeys.contractTitle.tr(),
                        ),
                      );
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
            ),
            Visibility(
              visible: _contractsViewModel.contractsNotifier.isLoadingMoreData,
              child: const CircularProgressIndicator(),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
