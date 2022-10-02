import 'package:emekteb/core/base/models/base_model.dart';

class SchedulerController extends BaseModel {
  String? code;
  String? message;
  Result? result;

  SchedulerController({this.code, this.message, this.result});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code ?? "";
    data['message'] = message ?? "";
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return SchedulerController(
      code: json['code'],
      message: json['message'],
      result: Result.fromJson(json["result"]),
    );
  }
}

class Result {
  List<Days>? days;
  List<ListModel>? list;

  Result({this.days, this.list});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['days'] != null) {
      days = <Days>[];
      json['days'].forEach((v) {
        days!.add(Days.fromJson(v));
      });
    }
    if (json['list'] != null) {
      list = <ListModel>[];
      json['list'].forEach((v) {
        list!.add(ListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (days != null) {
      data['days'] = days!.map((v) => v.toJson()).toList();
    }
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Days {
  String? info;
  String? day;
  int? dayOfWeek;
  bool? isCurrent;
  bool? isWorkDay;

  Days({this.info, this.day, this.dayOfWeek, this.isCurrent, this.isWorkDay});

  Days.fromJson(Map<String, dynamic> json) {
    info = json['info'] ?? "";
    day = json['day'] ?? "";
    dayOfWeek = json['dayOfWeek'] ?? "";
    isCurrent = json['isCurrent'] ?? "";
    isWorkDay = json['isWorkDay'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['info'] = info;
    data['day'] = day;
    data['dayOfWeek'] = dayOfWeek;
    data['isCurrent'] = isCurrent;
    data['isWorkDay'] = isWorkDay;
    return data;
  }
}

class ListModel {
  LessonHour? lessonHour;
  List<SchedulerList>? schedulerList;

  ListModel({this.lessonHour, this.schedulerList});

  ListModel.fromJson(Map<String, dynamic> json) {
    lessonHour = json['lessonHour'] != null
        ? LessonHour.fromJson(json['lessonHour'])
        : null;
    if (json['schedulerList'] != null) {
      schedulerList = <SchedulerList>[];
      json['schedulerList'].forEach((v) {
        schedulerList!.add(SchedulerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (lessonHour != null) {
      data['lessonHour'] = lessonHour!.toJson();
    }
    if (schedulerList != null) {
      data['schedulerList'] = schedulerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LessonHour {
  String? id;
  int? row;
  String? info;
  String? startHour;
  String? endHour;

  LessonHour({this.id, this.row, this.info, this.startHour, this.endHour});

  LessonHour.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    row = json['row'];
    info = json['info'] ?? "";
    startHour = json['startHour'] ?? "";
    endHour = json['endHour'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['row'] = row;
    data['info'] = info;
    data['startHour'] = startHour;
    data['endHour'] = endHour;
    return data;
  }
}

class SchedulerList {
  String? id;
  int? dayOfWeek;
  dynamic lessonOfDay;
  Week? week;
  ClassYearly? classYearly;
  LessonHour? lessonHour;
  Subject1? subject1;
  Subject1? subject2;
  Subject1? subject3;

  SchedulerList(
      {this.id,
      this.dayOfWeek,
      this.lessonOfDay,
      this.week,
      this.classYearly,
      this.lessonHour,
      this.subject1,
      this.subject2,
      this.subject3});

  SchedulerList.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    dayOfWeek = json['dayOfWeek'];
    lessonOfDay = json['lessonOfDay'];
    week = json['week'] != null ? Week.fromJson(json['week']) : null;
    classYearly = json['classYearly'] != null
        ? ClassYearly.fromJson(json['classYearly'])
        : null;
    lessonHour = json['lessonHour'] != null
        ? LessonHour.fromJson(json['lessonHour'])
        : null;
    subject1 = json['subject1'] != null
        ? Subject1.fromJson(json['subject1'])
        : Subject1();
    subject2 = json['subject2'] != null
        ? Subject1.fromJson(json['subject2'])
        : Subject1();
    subject3 = json['subject3'] != null
        ? Subject1.fromJson(json['subject3'])
        : Subject1();
    ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dayOfWeek'] = dayOfWeek;
    data['lessonOfDay'] = lessonOfDay;
    if (week != null) {
      data['week'] = week!.toJson();
    }
    if (classYearly != null) {
      data['classYearly'] = classYearly!.toJson();
    }
    if (lessonHour != null) {
      data['lessonHour'] = lessonHour!.toJson();
    }
    if (subject1 != null) {
      data['subject1'] = subject1!.toJson();
    }
    data['subject2'] = subject2;
    data['subject3'] = subject3;
    return data;
  }
}

class Week {
  int? id;
  String? info;
  String? startWeek;
  String? endWeek;
  bool? isCurrent;

  Week({this.id, this.info, this.startWeek, this.endWeek, this.isCurrent});

  Week.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    info = json['info'];
    startWeek = json['startWeek'];
    endWeek = json['endWeek'];
    isCurrent = json['isCurrent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['info'] = info ?? "";
    data['startWeek'] = startWeek ?? "";
    data['endWeek'] = endWeek ?? "";
    data['isCurrent'] = isCurrent;
    return data;
  }
}

class ClassYearly {
  String? id;
  dynamic utis;
  int? studentCount;
  dynamic lessonHourCount;
  int? classPrefix;
  String? classPrefixIndicator;
  ClassSchool? classSchool;
  dynamic classSection;
  Header? header;
  Gender? tendency;
  dynamic branchRoom;

  ClassYearly(
      {this.id,
      this.utis,
      this.studentCount,
      this.lessonHourCount,
      this.classPrefix,
      this.classPrefixIndicator,
      this.classSchool,
      this.classSection,
      this.header,
      this.tendency,
      this.branchRoom});

  ClassYearly.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    utis = json['utis'];
    studentCount = json['studentCount'];
    lessonHourCount = json['lessonHourCount'];
    classPrefix = json['classPrefix'];
    classPrefixIndicator = json['classPrefixIndicator'] ?? "";
    classSchool = json['classSchool'] != null
        ? ClassSchool.fromJson(json['classSchool'])
        : null;
    classSection = json['classSection'];
    header = json['header'] != null ? Header.fromJson(json['header']) : null;
    tendency =
        json['tendency'] != null ? Gender.fromJson(json['tendency']) : null;
    branchRoom = json['branchRoom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['utis'] = utis;
    data['studentCount'] = studentCount;
    data['lessonHourCount'] = lessonHourCount;
    data['classPrefix'] = classPrefix;
    data['classPrefixIndicator'] = classPrefixIndicator;
    if (classSchool != null) {
      data['classSchool'] = classSchool!.toJson();
    }
    data['classSection'] = classSection;
    if (header != null) {
      data['header'] = header!.toJson();
    }
    if (tendency != null) {
      data['tendency'] = tendency!.toJson();
    }
    data['branchRoom'] = branchRoom;
    return data;
  }
}

class ClassSchool {
  String? id;
  String? info;
  Section? section;
  Branch? branch;

  ClassSchool({this.id, this.info, this.section, this.branch});

  ClassSchool.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    info = json['info'] ?? "";
    section =
        json['section'] != null ? Section.fromJson(json['section']) : null;
    branch = json['branch'] != null ? Branch.fromJson(json['branch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['info'] = info;
    if (section != null) {
      data['section'] = section!.toJson();
    }
    if (branch != null) {
      data['branch'] = branch!.toJson();
    }
    return data;
  }
}

class Section {
  String? id;
  String? info;

  Section({this.id, this.info});

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    info = json['info'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['info'] = info;
    return data;
  }
}

class Branch {
  String? id;
  String? info;
  dynamic adress;
  dynamic webPage;
  dynamic email;
  dynamic phone1;
  dynamic phone2;
  dynamic fax1;
  dynamic fax2;
  dynamic mob1;
  dynamic mob2;
  String? prefix;

  Branch(
      {this.id,
      this.info,
      this.adress,
      this.webPage,
      this.email,
      this.phone1,
      this.phone2,
      this.fax1,
      this.fax2,
      this.mob1,
      this.mob2,
      this.prefix});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    info = json['info'] ?? "";
    adress = json['adress'];
    webPage = json['webPage'];
    email = json['email'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    fax1 = json['fax1'];
    fax2 = json['fax2'];
    mob1 = json['mob1'];
    mob2 = json['mob2'];
    prefix = json['prefix'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['info'] = info;
    data['adress'] = adress;
    data['webPage'] = webPage;
    data['email'] = email;
    data['phone1'] = phone1;
    data['phone2'] = phone2;
    data['fax1'] = fax1;
    data['fax2'] = fax2;
    data['mob1'] = mob1;
    data['mob2'] = mob2;
    data['prefix'] = prefix;
    return data;
  }
}

class Header {
  String? id;
  String? secondName;
  String? firstName;
  String? fatherName;
  String? tabel;
  Department? department;
  Gender? gender;
  String? fullName;
  dynamic employeeDocument;

  Header(
      {this.id,
      this.secondName,
      this.firstName,
      this.fatherName,
      this.tabel,
      this.department,
      this.gender,
      this.fullName,
      this.employeeDocument});

  Header.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    secondName = json['secondName'] ?? "";
    firstName = json['firstName'] ?? "";
    fatherName = json['fatherName'] ?? "";
    tabel = json['tabel'] ?? "";
    department = json['department'] != null
        ? Department.fromJson(json['department'])
        : null;
    gender = json['gender'] != null ? Gender.fromJson(json['gender']) : null;
    fullName = json['fullName'] ?? "";
    employeeDocument = json['employeeDocument'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['secondName'] = secondName;
    data['firstName'] = firstName;
    data['fatherName'] = fatherName;
    data['tabel'] = tabel;
    if (department != null) {
      data['department'] = department!.toJson();
    }
    if (gender != null) {
      data['gender'] = gender!.toJson();
    }
    data['fullName'] = fullName;
    data['employeeDocument'] = employeeDocument;
    return data;
  }
}

class Department {
  String? id;
  String? info;
  Branch? branch;
  dynamic department;

  Department({this.id, this.info, this.branch, this.department});

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    info = json['info'] ?? "";
    branch = json['branch'] != null ? Branch.fromJson(json['branch']) : null;
    department = json['department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['info'] = info;
    if (branch != null) {
      data['branch'] = branch!.toJson();
    }
    data['department'] = department;
    return data;
  }
}

class Gender {
  int? id;
  String? info;

  Gender({this.id, this.info});

  Gender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    info = json['info'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['info'] = info;
    return data;
  }
}

class Subject1 {
  String? id;
  Subject? subject;
  Header? teacher;
  Section? branchRoom;
  num? qrup;

  Subject1({this.id, this.subject, this.teacher, this.branchRoom, this.qrup});

  Subject1.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    subject =
        json['subject'] != null ? Subject.fromJson(json['subject']) : Subject();
    teacher = json['teacher'] != null ? Header.fromJson(json['teacher']) : null;
    branchRoom = json['branchRoom'] != null
        ? Section.fromJson(json['branchRoom'])
        : null;
    qrup = json['qrup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (subject != null) {
      data['subject'] = subject!.toJson();
    }
    if (teacher != null) {
      data['teacher'] = teacher!.toJson();
    }
    if (branchRoom != null) {
      data['branchRoom'] = branchRoom!.toJson();
    }
    data['qrup'] = qrup;
    return data;
  }
}

class Subject {
  String? id;
  String? info;
  String? infoEng;
  String? infoRus;

  Subject({this.id, this.info, this.infoEng, this.infoRus});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    info = json['info'] ?? "";
    infoEng = json['infoEng'] ?? "";
    infoRus = json['infoRus'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['info'] = info;
    data['infoEng'] = infoEng;
    data['infoRus'] = infoRus;
    return data;
  }
}
