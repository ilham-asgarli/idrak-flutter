import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/core/extensions/widget_extension.dart';
import 'package:emekteb/data-domain/school/modules/timetable_controller.dart';
import 'package:emekteb/presentation/features/timetable/components/timetable_view_page_item_page_item.dart';
import 'package:emekteb/presentation/features/timetable/notifiers/timetable_view_page_item_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TimetableViewPageItem extends StatefulWidget {
  final TimetableController? timetableController;
  final int index;

  const TimetableViewPageItem({
    required this.timetableController,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  State<TimetableViewPageItem> createState() => _TimetableViewPageItemState();
}

class _TimetableViewPageItemState extends State<TimetableViewPageItem>
    with AutomaticKeepAliveClientMixin<TimetableViewPageItem> {
  @override
  bool get wantKeepAlive => true;

  late TimetableViewPageItemNotifier timetableViewPageItemNotifier;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TimetableViewPageItemNotifier(),
        ),
        Consumer<TimetableViewPageItemNotifier>(
            builder: (context, notifier, _) {
          timetableViewPageItemNotifier = notifier;
          return buildPage(context);
        }),
      ],
    );
  }

  Padding buildPage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.normalValue,
        bottom: context.normalValue,
      ),
      child: Column(
        children: [
          buildDayTitle(),
          context.widget.verticalSpace(context, 0.015),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: widget.timetableController?.result
                      ?.dates?[widget.index].subjects?.length ??
                  0,
              itemBuilder: (context, index) {
                return TimetableViewPageItemPageItem(
                  key: PageStorageKey(index),
                  date:
                      widget.timetableController?.result?.dates?[widget.index],
                  index: index,
                );
              },
              onPageChanged: (index) {
                timetableViewPageItemNotifier.changeActiveIndex(index);
              },
            ),
          ),
          context.widget.verticalSpace(context, 0.03),
          buildPageIndicator(context),
        ],
      ),
    );
  }

  SizedBox buildDayTitle() {
    return SizedBox(
      width: context.dynamicWidth(0.5),
      child: Card(
        color: context.colorScheme.background,
        child: Padding(
          padding: context.paddingLow,
          child: Text(
            widget.timetableController?.result?.dates?[widget.index]
                    .lessonDay ??
                "",
            textAlign: TextAlign.center,
            style: context.textTheme.titleLarge,
          ),
        ),
      ),
    );
  }

  Widget buildPageIndicator(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: timetableViewPageItemNotifier.activeIndex,
      count: widget.timetableController?.result?.dates?[widget.index].subjects
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
