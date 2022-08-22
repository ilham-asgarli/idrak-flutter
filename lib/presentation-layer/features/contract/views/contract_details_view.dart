import 'package:easy_localization/easy_localization.dart';
import 'package:emekteb/generated/locale_keys.g.dart';
import 'package:emekteb/presentation-layer/features/contract/views/contract_payments.dart';
import 'package:emekteb/presentation-layer/features/contract/views/contract_payments_graphic_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/contract_details.dart';

class ContractDetailsView extends StatefulWidget {
  final ContractDetails contractDetails;

  const ContractDetailsView({required this.contractDetails, Key? key})
      : super(key: key);

  @override
  State<ContractDetailsView> createState() => _ContractDetailsViewState();
}

class _ContractDetailsViewState extends State<ContractDetailsView> {
  late List<Widget> tabs;

  @override
  void initState() {
    super.initState();

    tabs = [
      ContractPaymentsGraphicView(
        key: const PageStorageKey(0),
        contractDetails: widget.contractDetails,
      ),
      ContractPayments(
        key: const PageStorageKey(1),
        contractDetails: widget.contractDetails,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return buildPage();
  }

  Widget buildPage() {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: Text(LocaleKeys.contractPayments.tr()),
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
      children: tabs,
    );
  }
}
