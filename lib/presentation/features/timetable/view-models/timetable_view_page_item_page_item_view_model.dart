import 'package:easy_localization/easy_localization.dart';
import 'package:emekteb/core/base/view-models/base_view_model.dart';

import '../../../../data-domain/school/modules/timetable_controller.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../utils/ui/constants/app/app_constants.dart';

class TimetableViewPageItemPageItemViewModel with BaseViewModel {
  late Dates? date;

  getTimetableSubjectMap(int subjectIndex) {
    return {
      for (String s in AppConstants.timetableNames)
        s.tr(): getTimetableSubjectValueByName(s, subjectIndex)
    };
  }

  String? getTimetableSubjectValueByName(String name, int subjectIndex) {
    String? detail;
    Subjects? subject = date?.subjects?[subjectIndex];

    switch (name) {
      case LocaleKeys.timetable_no:
        detail = "${subjectIndex + 1}";
        break;
      case LocaleKeys.timetable_subject:
        detail = subject?.subject?.info;
        break;
      case LocaleKeys.timetable_teacher:
        detail = subject?.teacher?.fullName;
        break;
      case LocaleKeys.timetable_topic:
        detail = subject?.topic?.info;
        break;
      case LocaleKeys.timetable_homeTask:
        detail = subject?.homeTask;
        break;
      case LocaleKeys.timetable_mark:
        detail = subject?.mark;
        break;
      case LocaleKeys.timetable_markNote:
        detail = subject?.markNote;
        break;
      case LocaleKeys.timetable_contentInfo:
        detail = subject?.content?.info;
        break;
    }

    return detail ?? "";
  }
}
