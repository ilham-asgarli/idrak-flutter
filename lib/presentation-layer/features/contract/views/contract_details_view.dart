import 'package:easy_localization/easy_localization.dart';
import 'package:emekteb/generated/locale_keys.g.dart';
import 'package:emekteb/presentation-layer/features/contract/view-models/contract_details_view_model.dart';
import 'package:emekteb/presentation-layer/features/contract/views/contract_payments_graphic_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/base/views/base_view.dart';
import '../models/contract_details.dart';

class ContractDetailsView extends StatefulWidget {
  final ContractDetails contractDetails;

  const ContractDetailsView({required this.contractDetails, Key? key})
      : super(key: key);

  @override
  State<ContractDetailsView> createState() => _ContractDetailsViewState();
}

class _ContractDetailsViewState extends State<ContractDetailsView> {
  late ContractDetailsViewModel _contractDetailsViewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<ContractDetailsViewModel>(
      viewModel: ContractDetailsViewModel(),
      onModelReady: (model) async {
        _contractDetailsViewModel = model;
        model.init(context);
      },
      onPageBuilder:
          (BuildContext buildContext, ContractDetailsViewModel model) =>
              buildPage(),
    );
  }

  Widget buildPage() {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: Text(LocaleKeys.contractDetails.tr()),
            bottom: const TabBar(
              tabs: [
                Tab(icon: FaIcon(FontAwesomeIcons.chartLine)),
                Tab(icon: FaIcon(FontAwesomeIcons.moneyBillTransfer)),
              ],
            ),
          ),
          body: buildBody(),
        ),
      ),
    );
  }

  Widget buildBody() {
    return TabBarView(
      children: [
        ContractPaymentsGraphicView(
          contractDetails: widget.contractDetails,
        ),
        Text(""),
      ],
    );
  }
}
