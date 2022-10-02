import 'package:easy_localization/easy_localization.dart';
import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/core/extensions/string_extension.dart';
import 'package:emekteb/core/extensions/widget_extension.dart';
import 'package:emekteb/data-domain/school/modules/scheduler_controller.dart';
import 'package:emekteb/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class ScheduleViewPageItem extends StatelessWidget {
  final SchedulerController? schoolScheduler;
  final int dayIndex;

  const ScheduleViewPageItem({
    required this.schoolScheduler,
    required this.dayIndex,
    Key? key,
  }) : super(key: key);

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
                  (schoolScheduler?.result?.days?[dayIndex].info ?? "")
                      .toFirstLetterCapitalized(),
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleLarge,
                ),
              ),
              context.widget.verticalSpace(context, 0.005),
              Flexible(
                child: Text(
                  schoolScheduler?.result?.days?[dayIndex].day ?? "",
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
      itemCount: schoolScheduler?.result?.list?.length ?? 8,
      itemBuilder: (context, index) {
        return Visibility(
          visible: getSubject(index, 0)?.subject?.info != null,
          child: Card(
            color: context.colorScheme.background,
            child: Padding(
              padding: context.paddingNormal,
              child: Column(
                children: [
                  Text(
                    "${schoolScheduler?.result?.list?[index].lessonHour?.startHour ?? ""} - ${schoolScheduler?.result?.list?[index].lessonHour?.endHour ?? ""}",
                  ),
                  context.widget.verticalSpace(context, 0.01),
                  buildLecture(index),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Visibility(
          visible: getSubject(index, 0)?.subject?.info != null,
          child: context.widget.verticalSpace(context, 0.01),
        );
      },
    );
  }

  Widget buildLecture(listIndex) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Visibility(
          visible: getSubject(listIndex, index)?.subject?.info != null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  textAlign: TextAlign.center,
                  getSubject(listIndex, index)?.subject?.info ?? "",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  textAlign: TextAlign.center,
                  getSubject(listIndex, index)?.teacher?.fullName ?? "",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      textAlign: TextAlign.center,
                      "${LocaleKeys.scheduleSubjectInfo_qrup.tr()}: ${getSubject(listIndex, index)?.qrup ?? ""}",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  context.widget.horizontalSpace(context, 0.03),
                  Flexible(
                    child: Text(
                      textAlign: TextAlign.center,
                      "${LocaleKeys.scheduleSubjectInfo_room.tr()}: ${getSubject(listIndex, index)?.branchRoom?.info ?? ""}",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Visibility(
          visible: getSubject(listIndex, index + 1)?.subject?.info != null,
          child: context.widget.verticalSpace(context, 0.01),
        );
      },
    );
  }

  Subject1? getSubject(listIndex, index) {
    switch (index) {
      case 0:
        return schoolScheduler
            ?.result?.list?[listIndex].schedulerList?[dayIndex].subject1;
      case 1:
        return schoolScheduler
            ?.result?.list?[listIndex].schedulerList?[dayIndex].subject2;
      case 2:
        return schoolScheduler
            ?.result?.list?[listIndex].schedulerList?[dayIndex].subject3;
      default:
        return null;
    }
  }
}
