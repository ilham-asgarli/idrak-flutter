import 'package:emekteb/core/base/models/base_model.dart';

class TimetableController extends BaseModel<TimetableController> {
  String? code;
  String? message;
  Result? result;

  TimetableController({this.code, this.message, this.result});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }

  @override
  TimetableController fromJson(Map<String, dynamic> json) {
    return TimetableController(
      code: json['code'],
      message: json['message'],
      result: json['result'] != null ? Result.fromJson(json['result']) : null,
    );
  }
}

class Result {
  List<Dates>? dates;

  Result({this.dates});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['dates'] != null) {
      dates = <Dates>[];
      json['dates'].forEach((v) {
        dates!.add(Dates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dates != null) {
      data['dates'] = dates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dates {
  String? lessonDay;
  List<Subjects>? subjects;

  Dates({this.lessonDay, this.subjects});

  Dates.fromJson(Map<String, dynamic> json) {
    lessonDay = json['lessonDay'];
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lessonDay'] = lessonDay;
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subjects {
  String? id;
  Teacher? teacher;
  LessonHour? lessonHour;
  Subject? subject;
  dynamic homeTask;
  dynamic mark;
  dynamic markNote;
  dynamic content;
  dynamic topic;
  dynamic topic2;
  dynamic mediaLink;
  dynamic mediaLink2;

  Subjects(
      {this.id,
      this.teacher,
      this.lessonHour,
      this.subject,
      this.homeTask,
      this.mark,
      this.markNote,
      this.content,
      this.topic,
      this.topic2,
      this.mediaLink,
      this.mediaLink2});

  Subjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacher =
        json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
    lessonHour = json['lessonHour'] != null
        ? LessonHour.fromJson(json['lessonHour'])
        : null;
    subject =
        json['subject'] != null ? Subject.fromJson(json['subject']) : null;
    homeTask = json['homeTask'];
    mark = json['mark'];
    markNote = json['markNote'];
    content = json['content'];
    topic = json['topic'];
    topic2 = json['topic2'];
    mediaLink = json['mediaLink'];
    mediaLink2 = json['mediaLink2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (teacher != null) {
      data['teacher'] = teacher!.toJson();
    }
    if (lessonHour != null) {
      data['lessonHour'] = lessonHour!.toJson();
    }
    if (subject != null) {
      data['subject'] = subject!.toJson();
    }
    data['homeTask'] = homeTask;
    data['mark'] = mark;
    data['markNote'] = markNote;
    data['content'] = content;
    data['topic'] = topic;
    data['topic2'] = topic2;
    data['mediaLink'] = mediaLink;
    data['mediaLink2'] = mediaLink2;
    return data;
  }
}

class Teacher {
  String? id;
  String? secondName;
  String? firstName;
  String? fatherName;
  String? tabel;
  Department? department;
  Gender? gender;
  String? fullName;
  dynamic employeeDocument;

  Teacher(
      {this.id,
      this.secondName,
      this.firstName,
      this.fatherName,
      this.tabel,
      this.department,
      this.gender,
      this.fullName,
      this.employeeDocument});

  Teacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    secondName = json['secondName'];
    firstName = json['firstName'];
    fatherName = json['fatherName'];
    tabel = json['tabel'];
    department = json['department'] != null
        ? Department.fromJson(json['department'])
        : null;
    gender = json['gender'] != null ? Gender.fromJson(json['gender']) : null;
    fullName = json['fullName'];
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
    id = json['id'];
    info = json['info'];
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
    id = json['id'];
    info = json['info'];
    adress = json['adress'];
    webPage = json['webPage'];
    email = json['email'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    fax1 = json['fax1'];
    fax2 = json['fax2'];
    mob1 = json['mob1'];
    mob2 = json['mob2'];
    prefix = json['prefix'];
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

class Gender {
  int? id;
  String? info;

  Gender({this.id, this.info});

  Gender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    info = json['info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['info'] = info;
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
    id = json['id'];
    row = json['row'];
    info = json['info'];
    startHour = json['startHour'];
    endHour = json['endHour'];
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

class Subject {
  String? id;
  String? info;
  dynamic infoEng;
  String? infoRus;

  Subject({this.id, this.info, this.infoEng, this.infoRus});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    info = json['info'];
    infoEng = json['infoEng'];
    infoRus = json['infoRus'];
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
