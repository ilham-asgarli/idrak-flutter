import 'package:easy_localization/easy_localization.dart';
import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/generated/locale_keys.g.dart';
import 'package:emekteb/presentation-layer/features/contract/components/contract_payments_place_holder.dart';
import 'package:emekteb/presentation-layer/features/contract/models/contract_details.dart';
import 'package:emekteb/presentation-layer/features/contract/models/contract_payment_details.dart';
import 'package:emekteb/presentation-layer/widgets/have_no.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/base/views/base_view.dart';
import '../components/contract_payments_view_page_item.dart';
import '../view-models/contract_payments_view_model.dart';

class ContractPayments extends StatefulWidget {
  final ContractDetails? contractDetails;

  const ContractPayments({required this.contractDetails, Key? key})
      : super(key: key);

  @override
  State<ContractPayments> createState() => _ContractPaymentsState();
}

class _ContractPaymentsState extends State<ContractPayments> with AutomaticKeepAliveClientMixin<ContractPayments>{
  @override
  bool get wantKeepAlive => true;

  late ContractPaymentsViewModel _contractPaymentsViewModel;

  PageController pageController = PageController();

  @override
  void dispose() {
    _contractPaymentsViewModel.contractPaymentsNotifier.isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BaseView<ContractPaymentsViewModel>(
      viewModel: ContractPaymentsViewModel(),
      onModelReady: (model) async {
        _contractPaymentsViewModel = model;
        _contractPaymentsViewModel.contractDetails = widget.contractDetails;
        model.init(context);
      },
      onPageBuilder:
          (BuildContext buildContext, ContractPaymentsViewModel model) =>
              buildPage(),
    );
  }

  Widget buildPage() {
    return _contractPaymentsViewModel.contractPaymentsNotifier.isMainDataLoading
        ? const ContractPaymentsPlaceHolder()
        : _contractPaymentsViewModel.getPaymentListLength() > 0
            ? buildMainPage()
            : HaveNo(
                description: LocaleKeys.haveNoPayment.tr(),
                iconData: FontAwesomeIcons.moneyBillTransfer,
              );
  }

  Widget buildMainPage() {
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
              itemCount: _contractPaymentsViewModel.getPaymentListLength(),
              itemBuilder: (context, int index) {
                return ContractPaymentsViewPageItem(
                  key: PageStorageKey(index),
                  contractPaymentDetails: ContractPaymentDetails(
                    contractDetails: widget.contractDetails,
                    contractPaymentIndex: index,
                    invoicesController:
                        _contractPaymentsViewModel.invoicesController,
                  ),
                );
              },
              onPageChanged: (index) {
                _contractPaymentsViewModel.contractPaymentsNotifier
                    .changeActiveIndex(index);
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
      activeIndex:
          _contractPaymentsViewModel.contractPaymentsNotifier.activeIndex,
      count: _contractPaymentsViewModel.getPaymentListLength(),
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
