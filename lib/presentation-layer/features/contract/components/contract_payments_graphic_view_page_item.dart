import 'package:easy_localization/easy_localization.dart';
import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/core/extensions/widget_extension.dart';
import 'package:emekteb/presentation-layer/widgets/my_table.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/base/views/base_view.dart';
import '../../../../generated/locale_keys.g.dart';
import '../models/contract_details.dart';
import '../view-models/contract_payments_graphic_view_page_item_view_model.dart';

class ContractPaymentsGraphicViewPageItem extends StatefulWidget {
  final ContractDetails contractDetails;
  final int index;

  const ContractPaymentsGraphicViewPageItem(
      {required this.contractDetails, required this.index, Key? key})
      : super(key: key);

  @override
  State<ContractPaymentsGraphicViewPageItem> createState() =>
      _ContractPaymentsGraphicViewPageItemState();
}

class _ContractPaymentsGraphicViewPageItemState
    extends State<ContractPaymentsGraphicViewPageItem>
    with AutomaticKeepAliveClientMixin<ContractPaymentsGraphicViewPageItem> {
  @override
  bool get wantKeepAlive => true;

  late ContractPaymentsGraphicViewPageItemViewModel _viewModel;

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BaseView<ContractPaymentsGraphicViewPageItemViewModel>(
      viewModel: ContractPaymentsGraphicViewPageItemViewModel(),
      onModelReady: (model) async {
        _viewModel = model;
        _viewModel.contractDetails = widget.contractDetails;
        _viewModel.index = widget.index;
        model.init(context);
      },
      onPageBuilder: (BuildContext buildContext,
              ContractPaymentsGraphicViewPageItemViewModel model) =>
          buildPage(),
    );
  }

  buildPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.mustPay.tr(),
          style: context.textTheme.titleLarge,
        ),
        context.widget.verticalSpace(context, 0.015),
        MyTable(map: _viewModel.getContractPaymentDetailsMap()),
        context.widget.verticalSpace(context, 0.03),
        Text(
          LocaleKeys.payed.tr(),
          style: context.textTheme.titleLarge,
        ),
        context.widget.verticalSpace(context, 0.015),
        ExpandablePageView.builder(
          controller: pageController,
          itemCount:
          _viewModel.getContractPaymentPortionDetailsMapList().length,
          itemBuilder: (context, index) {
            return MyTable(
                map: _viewModel
                    .getContractPaymentPortionDetailsMapList()[index]);
          },
          onPageChanged: (index) {
            _viewModel.notifier.changeActiveIndex(index);
          },
        ),
        context.widget.verticalSpace(context, 0.03),
        buildPageIndicator(),
      ],
    );
  }

  Widget buildPageIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: _viewModel.notifier.activeIndex,
      count: _viewModel.getContractPaymentPortionDetailsMapList().length,
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
