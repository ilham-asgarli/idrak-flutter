import 'package:centered_singlechildscrollview/centered_singlechildscrollview.dart';
import 'package:emekteb/core/base/views/base_view.dart';
import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/utils/constants/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../components/schedule_body_place_holder.dart';
import '../../../components/end_drawer_place_holder.dart';
import '../components/schedule_view_page_item.dart';
import '../../../../utils/models/choosing_end_drawer_item.dart';
import '../../../../utils/models/main_end_drawer_item.dart';
import '../notifiers/schedule_notifier.dart';
import '../view-models/schedule_view_model.dart';

class ScheduleView extends StatefulWidget {
  final String title;

  const ScheduleView({required this.title, Key? key}) : super(key: key);

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  late ScheduleViewModel _scheduleViewModel;

  PageController pageController = PageController();

  @override
  void dispose() {
    _scheduleViewModel.scheduleNotifier.isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ScheduleNotifier(),
        ),
        Consumer<ScheduleNotifier>(builder: (context, notifier, _) {
          return BaseView<ScheduleViewModel>(
            viewModel: ScheduleViewModel(),
            onModelReady: (model) async {
              _scheduleViewModel = model;
              _scheduleViewModel.scheduleNotifier = notifier;
              model.init(context);
            },
            onPageBuilder:
                (BuildContext buildContext, ScheduleViewModel model) =>
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
          leading: const BackButton(),
          title: Text(widget.title),
          actions: [
            Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: const Icon(Icons.filter_list_rounded),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
          ],
        ),
        endDrawer: Drawer(
          child: buildEndDrawer(),
        ),
        onEndDrawerChanged: (isOpen) {
          if (!isOpen) {
            _scheduleViewModel.scheduleNotifier
                .changeEndDrawerEnum(SCHEDULE_END_DRAWER.MAIN);
          }
        },
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return _scheduleViewModel.scheduleNotifier.isBodyWidgetLoading
        ? const ScheduleBodyPlaceHolder()
        : buildMainBody();
  }

  Widget buildMainBody() {
    return Column(
      children: [
        Padding(
          padding: context.paddingNormalVertical,
          child: CenteredSingleChildScrollView(
            maxWidth: false,
            maxHeight: false,
            axis: Axis.horizontal,
            children: [
              buildPageIndicator(),
            ],
          ),
        ),
        Expanded(
          child: buildPageView(),
        ),
      ],
    );
  }

  Widget buildPageIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: _scheduleViewModel.scheduleNotifier.activePage,
      count: _scheduleViewModel.scheduleDayListLength(),
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
      itemCount: _scheduleViewModel.scheduleDayListLength(),
      itemBuilder: (context, index) {
        return ScheduleViewPageItem(
          schoolScheduler: _scheduleViewModel.schedulerController,
          dayIndex: index,
        );
      },
      onPageChanged: (int index) {
        _scheduleViewModel.scheduleNotifier.changeActivePage(index);
      },
    );
  }

  Widget? buildEndDrawer() {
    return _scheduleViewModel.scheduleNotifier.isMainEndDrawerLoading
        ? const EndDrawerPlaceHolder()
        : _scheduleViewModel.scheduleNotifier.endDrawerEnum ==
                SCHEDULE_END_DRAWER.MAIN
            ? buildMainEndDrawer()
            : buildChoosingEndDrawer();
  }

  Widget buildMainEndDrawer() {
    return ListView.builder(
      itemCount: _scheduleViewModel.scheduleNotifier.mainEndDrawerItems.length,
      itemBuilder: (context, index) {
        return Visibility(
          visible: (index != 1 ||
              _scheduleViewModel.role == ROLE.ROLE_SCHOOL_STUDENT_PARENT),
          //(index != 0 || _scheduleViewModel.role == ROLE.ROLE_ADMIN) &&
          child: ListTile(
            title: Text(_scheduleViewModel
                .scheduleNotifier.mainEndDrawerItems[index].title),
            onTap: () {
              _scheduleViewModel.scheduleNotifier
                  .changeEndDrawerEnum(SCHEDULE_END_DRAWER.CHOOSING);
              _scheduleViewModel.scheduleNotifier.activeChoosingEndDrawer =
                  index;
            },
          ),
        );
      },
    );
  }

  Widget buildChoosingEndDrawer() {
    return _scheduleViewModel.scheduleNotifier.isChoosingEndDrawerLoading
        ? const EndDrawerPlaceHolder()
        : buildMainChoosingEndDrawer();
  }

  Widget buildMainChoosingEndDrawer() {
    int mainIndex = _scheduleViewModel.scheduleNotifier.activeChoosingEndDrawer;
    List<MainEndDrawerItem> mainEndDrawerItems =
        _scheduleViewModel.scheduleNotifier.mainEndDrawerItems;
    List<ChoosingEndDrawerItem>? choosingEndDrawerItems =
        mainEndDrawerItems[mainIndex].choosingEndDrawerItems;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              BackButton(
                onPressed: () {
                  _scheduleViewModel.scheduleNotifier
                      .changeEndDrawerEnum(SCHEDULE_END_DRAWER.MAIN);
                },
              ),
              Text(
                mainEndDrawerItems[mainIndex].title,
                style: context.textTheme.titleLarge,
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: choosingEndDrawerItems?.length,
            itemBuilder: (context, choosingIndex) {
              return ListTile(
                leading: choosingIndex ==
                        mainEndDrawerItems[mainIndex]
                            .selectedChoosingEndDrawerItemIndex
                    ? const Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : null,
                title: Text(choosingEndDrawerItems?[choosingIndex].title ?? ""),
                onTap: () {
                  _scheduleViewModel.onTapChoosingEndDrawerItem(
                      mainIndex, choosingIndex);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
