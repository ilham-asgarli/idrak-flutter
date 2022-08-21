import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/core/extensions/string_extension.dart';
import 'package:emekteb/core/extensions/widget_extension.dart';
import 'package:emekteb/data-domain-layer/school/modules/school_scheduler.dart';
import 'package:flutter/material.dart';

class TimetableWeekItem extends StatelessWidget {
  final SchoolScheduler schoolScheduler;
  final int day;

  const TimetableWeekItem(
      {required this.schoolScheduler, required this.day, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: context.normalValue,
          right: context.normalValue,
          bottom: context.normalValue,
        ),
        child: Column(
          children: [
            buildDayTitle(context),
            context.widget.verticalSpace(context, 0.03),
            buildLectures(),
          ],
        ),
      ),
    );
  }

  SizedBox buildDayTitle(BuildContext context) {
    return SizedBox(
      width: context.dynamicWidth(0.5),
      child: Card(
        color: context.colorScheme.background,
        child: Padding(
          padding: context.paddingLow,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  (schoolScheduler.result?.days?[day].info ?? "")
                      .toFirstLetterCapitalized(),
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleLarge,
                ),
              ),
              context.widget.verticalSpace(context, 0.005),
              Flexible(
                child: Text(
                  schoolScheduler.result?.days?[day].day ?? "",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLectures() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: schoolScheduler.result?.list?.length ?? 8,
      itemBuilder: (context, index) {
        return Card(
          color: context.colorScheme.background,
          child: Padding(
            padding: context.paddingNormal,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    textAlign: TextAlign.center,
                    "${index + 1}. ${schoolScheduler.result?.list?[index].schedulerList?[day].subject1?.subject?.info ?? ""}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                context.widget.verticalSpace(context, 0.005),
                Text(
                  "${schoolScheduler.result?.list?[index].lessonHour?.startHour ?? ""} - ${schoolScheduler.result?.list?[index].lessonHour?.endHour ?? ""}",
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return context.widget.verticalSpace(context, 0.01);
      },
    );
  }
}
