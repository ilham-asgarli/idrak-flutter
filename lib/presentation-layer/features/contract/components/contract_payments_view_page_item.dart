import 'package:emekteb/presentation-layer/features/contract/models/contract_payment_details.dart';
import 'package:emekteb/presentation-layer/widgets/my_table.dart';
import 'package:flutter/material.dart';

import '../../../../core/base/views/base_view.dart';
import '../view-models/contract_payments_view_page_item_view_model.dart';

class ContractPaymentsViewPageItem extends StatefulWidget {
  final ContractPaymentDetails contractPaymentDetails;

  const ContractPaymentsViewPageItem({
    required this.contractPaymentDetails,
    Key? key,
  }) : super(key: key);

  @override
  State<ContractPaymentsViewPageItem> createState() =>
      _ContractPaymentsViewPageItemState();
}

class _ContractPaymentsViewPageItemState
    extends State<ContractPaymentsViewPageItem>
    with AutomaticKeepAliveClientMixin<ContractPaymentsViewPageItem> {
  @override
  bool get wantKeepAlive => true;

  late ContractPaymentsViewPageItemViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BaseView<ContractPaymentsViewPageItemViewModel>(
      viewModel: ContractPaymentsViewPageItemViewModel(),
      onModelReady: (model) async {
        _viewModel = model;
        _viewModel.contractPaymentDetails = widget.contractPaymentDetails;
        model.init(context);
      },
      onPageBuilder: (BuildContext buildContext,
              ContractPaymentsViewPageItemViewModel model) =>
          buildPage(),
    );
  }

  Widget buildPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyTable(
          map: _viewModel.getContractPaymentMap(),
        ),
      ],
    );
  }
}
