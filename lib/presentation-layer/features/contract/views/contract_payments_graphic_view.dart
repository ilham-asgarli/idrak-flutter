import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/presentation-layer/features/contract/components/contract_payments_graphic_view_page_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/contract_details.dart';
import '../notifiers/contract_payments_graphic_view_page_notifier.dart';

class ContractPaymentsGraphicView extends StatefulWidget {
  final ContractDetails contractDetails;

  const ContractPaymentsGraphicView({required this.contractDetails, Key? key})
      : super(key: key);

  @override
  State<ContractPaymentsGraphicView> createState() =>
      _ContractPaymentsGraphicViewState();
}

class _ContractPaymentsGraphicViewState
    extends State<ContractPaymentsGraphicView> {
  late ContractPaymentsGraphicViewPageNotifier notifier;

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ContractPaymentsGraphicViewPageNotifier>(context);

    return Padding(
      padding: EdgeInsets.only(
        left: context.normalValue,
        right: context.normalValue,
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: context.normalValue),
            child: buildPageIndicator(),
          ),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              scrollDirection: Axis.vertical,
              itemCount: widget
                      .contractDetails
                      .contractController
                      ?.result?[widget.contractDetails.contractIndex]
                      .contractPaymentOrder
                      ?.contractPaymentOrderLine
                      ?.length ??
                  0,
              itemBuilder: (context, int index) {
                return ContractPaymentsGraphicViewPageItem(
                  key: PageStorageKey(index),
                  contractDetails: widget.contractDetails,
                  index: index,
                );
              },
              onPageChanged: (index) {
                notifier.changeActiveIndex(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPageIndicator() {
    return AnimatedSmoothIndicator(
      axisDirection: Axis.vertical,
      activeIndex: notifier.activeIndex,
      count: widget
              .contractDetails
              .contractController
              ?.result?[widget.contractDetails.contractIndex]
              .contractPaymentOrder
              ?.contractPaymentOrderLine
              ?.length ??
          0,
      effect: WormEffect(
        activeDotColor: context.colorScheme.background,
      ),
      onDotClicked: (int index) {
        pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      },
    );
  }
}
