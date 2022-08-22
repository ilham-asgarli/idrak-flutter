import 'package:easy_localization/easy_localization.dart';
import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/generated/locale_keys.g.dart';
import 'package:emekteb/presentation-layer/features/contract/components/contract_body_place_holder.dart';
import 'package:emekteb/presentation-layer/features/contract/components/contract_view_page_item.dart';
import 'package:emekteb/presentation-layer/widgets/have_no.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/base/views/base_view.dart';
import '../view-models/contract_view_model.dart';

class ContractView extends StatefulWidget {
  final String title;

  const ContractView({required this.title, Key? key}) : super(key: key);

  @override
  State<ContractView> createState() => _ContractViewState();
}

class _ContractViewState extends State<ContractView> {
  late ContractViewModel _contractViewModel;

  PageController pageController = PageController(
    /*viewportFraction:
                _contractViewModel.contractListLength() > 1 ? 0.9 : 1,*/
    initialPage: 0,
  );

  @override
  void dispose() {
    _contractViewModel.contractNotifier.isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ContractViewModel>(
      viewModel: ContractViewModel(),
      onModelReady: (model) async {
        _contractViewModel = model;
        model.init(context);
      },
      onPageBuilder: (BuildContext buildContext, ContractViewModel model) =>
          buildPage(),
    );
  }

  Widget buildPage() {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(widget.title),
        ),
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return _contractViewModel.contractNotifier.isMainDataLoading
        ? const ContractBodyPlaceHolder()
        : _contractViewModel.isCustomerHaveContract()
            ? buildMainBody()
            : HaveNo(
                description: LocaleKeys.haveNoContract.tr(),
                iconData: FontAwesomeIcons.fileContract,
              );
  }

  Widget buildMainBody() {
    return Column(
      children: [
        Padding(
          padding: context.paddingNormal,
          child: buildPageIndicator(),
        ),
        Expanded(
          child: buildPageView(),
        ),
      ],
    );
  }

  Widget buildPageIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: _contractViewModel.contractNotifier.activeIndex,
      count: _contractViewModel.contractListLength(),
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

  PageView buildPageView() {
    return PageView.builder(
      padEnds: false,
      controller: pageController,
      itemCount: _contractViewModel.contractListLength(),
      onPageChanged: (int index) {
        _contractViewModel.contractNotifier.changeActiveIndex(index);
      },
      itemBuilder: (context, index) {
        return ContractViewPageItem(
          key: PageStorageKey(index),
          contractViewModel: _contractViewModel,
          index: index,
        );
      },
    );
  }
}
