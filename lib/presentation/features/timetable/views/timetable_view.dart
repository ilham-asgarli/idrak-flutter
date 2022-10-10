import 'package:centered_singlechildscrollview/centered_singlechildscrollview.dart';
import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/presentation/features/timetable/components/timetable_body_place_holder.dart';
import 'package:emekteb/presentation/features/timetable/components/timetable_view_page_item.dart';
import 'package:emekteb/presentation/features/timetable/notifiers/timetable_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/base/views/base_view.dart';
import '../../../../utils/app/constants/enums/api_enum.dart';
import '../../../../utils/ui/constants/enums/enums.dart';
import '../../../../utils/ui/models/choosing_end_drawer_item.dart';
import '../../../../utils/ui/models/main_end_drawer_item.dart';
import '../../../components/end_drawer_place_holder.dart';
import '../constants/enums.dart';
import '../view-models/timetable_view_model.dart';

class TimetableView extends StatefulWidget {
  final String title;

  const TimetableView({required this.title, Key? key}) : super(key: key);

  @override
  State<TimetableView> createState() => _TimetableViewState();
}

class _TimetableViewState extends State<TimetableView> {
  late TimetableViewModel _timetableViewModel;

  final PageController _pageController = PageController();

  @override
  void dispose() {
    _timetableViewModel.timetableNotifier.isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TimetableNotifier(),
        ),
        Consumer<TimetableNotifier>(builder: (context, notifier, _) {
          return BaseView<TimetableViewModel>(
            viewModel: TimetableViewModel(),
            onModelReady: (model) async {
              _timetableViewModel = model;
              _timetableViewModel.timetableNotifier = notifier;
              model.init(context);
            },
            onPageBuilder:
                (BuildContext buildContext, TimetableViewModel model) =>
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
            _timetableViewModel.timetableNotifier
                .changeEndDrawerEnum(TIMETABLE_END_DRAWER.MAIN);
          }
        },
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return _timetableViewModel.timetableNotifier.isBodyWidgetLoading
        ? const TimetableBodyPlaceHolder()
        : buildMainBody();
  }

  Widget buildMainBody() {
    return Padding(
      padding: EdgeInsets.only(
        left: context.normalValue,
        right: context.normalValue,
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: context.normalValue),
            child: CenteredSingleChildScrollView(
              maxWidth: false,
              maxHeight: false,
              children: [
                buildPageIndicator(),
              ],
            ),
          ),
          Expanded(
            child: buildPageView(),
          ),
        ],
      ),
    );
  }

  Widget buildPageIndicator() {
    return AnimatedSmoothIndicator(
      axisDirection: Axis.vertical,
      activeIndex: _timetableViewModel.timetableNotifier.activePage,
      count: _timetableViewModel.timetableDayListLength(),
      effect: WormEffect(
        activeDotColor: context.colorScheme.background,
      ),
      onDotClicked: (int index) {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      },
    );
  }

  PageView buildPageView() {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: _timetableViewModel.timetableDayListLength(),
      itemBuilder: (context, index) {
        return TimetableViewPageItem(
          key: PageStorageKey(index),
          timetableController: _timetableViewModel.timetableController,
          index: index,
        );
      },
      onPageChanged: (int index) {
        _timetableViewModel.timetableNotifier.changeActivePage(index);
      },
    );
  }

  Widget? buildEndDrawer() {
    return _timetableViewModel.timetableNotifier.isMainEndDrawerLoading
        ? const EndDrawerPlaceHolder()
        : _timetableViewModel.timetableNotifier.endDrawerEnum ==
                TIMETABLE_END_DRAWER.MAIN
            ? buildMainEndDrawer()
            : buildChoosingEndDrawer();
  }

  Widget buildMainEndDrawer() {
    return ListView.builder(
      itemCount:
          _timetableViewModel.timetableNotifier.mainEndDrawerItems.length,
      itemBuilder: (context, index) {
        return Visibility(
          visible: index != 0 ||
              _timetableViewModel.role == ROLE.ROLE_SCHOOL_STUDENT_PARENT,
          child: ListTile(
            title: Text(_timetableViewModel
                .timetableNotifier.mainEndDrawerItems[index].title),
            onTap: () {
              _timetableViewModel.timetableNotifier
                  .changeEndDrawerEnum(TIMETABLE_END_DRAWER.CHOOSING);
              _timetableViewModel.timetableNotifier.activeChoosingEndDrawer =
                  index;
            },
          ),
        );
      },
    );
  }

  Widget buildChoosingEndDrawer() {
    return _timetableViewModel.timetableNotifier.isChoosingEndDrawerLoading
        ? const EndDrawerPlaceHolder()
        : buildMainChoosingEndDrawer();
  }

  Widget buildMainChoosingEndDrawer() {
    int mainIndex =
        _timetableViewModel.timetableNotifier.activeChoosingEndDrawer;
    List<MainEndDrawerItem> mainEndDrawerItems =
        _timetableViewModel.timetableNotifier.mainEndDrawerItems;
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
                  _timetableViewModel.timetableNotifier
                      .changeEndDrawerEnum(TIMETABLE_END_DRAWER.MAIN);
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
                  _timetableViewModel.onTapChoosingEndDrawerItem(
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
