import 'package:easy_localization/easy_localization.dart';
import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/core/extensions/widget_extension.dart';
import 'package:emekteb/presentation-layer/features/contract/view-models/contract_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../core/init/navigation/navigation_service.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../widgets/my_table.dart';
import '../models/contract_details.dart';

class ContractViewPageItem extends StatefulWidget {
  final ContractViewModel contractViewModel;
  final int index;

  const ContractViewPageItem(
      {required this.contractViewModel, required this.index, Key? key})
      : super(key: key);

  @override
  State<ContractViewPageItem> createState() => _ContractViewPageItemState();
}

class _ContractViewPageItemState extends State<ContractViewPageItem>
    with AutomaticKeepAliveClientMixin<ContractViewPageItem> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: context.normalValue,
        right: context.normalValue,
        bottom: context.normalValue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.contractConditions.tr(),
            style: context.textTheme.titleLarge,
          ),
          context.widget.verticalSpace(context, 0.015),
          MyTable(
            map: widget
                .contractViewModel.contractNotifier.contractItems[widget.index],
          ),
          context.widget.verticalSpace(context, 0.03),
          Text(
            LocaleKeys.parent.tr(),
            style: context.textTheme.titleLarge,
          ),
          context.widget.verticalSpace(context, 0.015),
          MyTable(
            map: widget
                .contractViewModel.contractNotifier.customerItems[widget.index],
          ),
          context.widget.verticalSpace(context, 0.03),
          Text(
            LocaleKeys.student.tr(),
            style: context.textTheme.titleLarge,
          ),
          context.widget.verticalSpace(context, 0.015),
          MyTable(
            map: widget
                .contractViewModel.contractNotifier.studentItems[widget.index],
          ),
          context.widget.verticalSpace(context, 0.03),
          SizedBox(
            height: context.dynamicWidth(0.5),
            child: buildChart(context),
          ),
          context.widget.verticalSpace(context, 0.015),
          buildChartDescription(context),
          context.widget.verticalSpace(context, 0.03),
          ElevatedButton.icon(
            icon: const Icon(Icons.info),
            onPressed: () {
              NavigationService.instance.navigateToPage(
                path: NavigationConstants.CONTRACT_DETAILS,
                data: ContractDetails(
                    contractIndex: widget.index,
                    contractController:
                        widget.contractViewModel.contractController),
              );
            },
            label: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                LocaleKeys.contractPayments.tr(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChart(BuildContext context) {
    num? totalPaymentPercent = widget.contractViewModel.contractController
        ?.result?[widget.index].contractPaymentOrder?.totalPaymentPercent;
    num? totalDeptPercent = widget.contractViewModel.contractController
        ?.result?[widget.index].contractPaymentOrder?.totalDeptPercent;

    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: context.dynamicWidth(0.1),
        sections: [
          PieChartSectionData(
            color: Colors.green,
            value: totalPaymentPercent?.toDouble(),
            radius: 25,
            title: "$totalPaymentPercent%",
            titleStyle: const TextStyle(color: Colors.white),
          ),
          PieChartSectionData(
            color: Colors.red,
            value: totalDeptPercent?.toDouble(),
            radius: 45,
            title: "$totalDeptPercent%",
            titleStyle: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget buildChartDescription(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Container(
              width: 20,
              height: 20,
              color: Colors.red,
            ),
            context.widget.horizontalSpace(context, 0.03),
            Text(LocaleKeys.mustPay.tr()),
          ],
        ),
        Row(
          children: [
            Container(
              width: 20,
              height: 20,
              color: Colors.green,
            ),
            context.widget.horizontalSpace(context, 0.03),
            Text(LocaleKeys.payed.tr()),
          ],
        ),
      ],
    );
  }
}
