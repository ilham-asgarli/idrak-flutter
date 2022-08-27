import 'package:emekteb/core/base/models/base_model.dart';

class ClassYearlyController extends BaseModel<ClassYearlyController> {
  String? code;
  String? message;
  List<Result>? result;

  ClassYearlyController({this.code, this.message, this.result});

  @override
  ClassYearlyController fromJson(Map<String, dynamic> json) {
    return ClassYearlyController(
      code: json['code'],
      message: json['message'],
      result: json["result"] != null
          ? List<Result>.from(json["result"].map((x) => Result.fromJson(x)))
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
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
  Section? branchRoom;

  Result(
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

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    utis = json['utis'];
    studentCount = json['studentCount'];
    lessonHourCount = json['lessonHourCount'];
    classPrefix = json['classPrefix'];
    classPrefixIndicator = json['classPrefixIndicator'];
    classSchool = json['classSchool'] != null
        ? ClassSchool.fromJson(json['classSchool'])
        : null;
    classSection = json['classSection'];
    header = json['header'] != null ? Header.fromJson(json['header']) : null;
    tendency =
        json['tendency'] != null ? Gender.fromJson(json['tendency']) : null;
    branchRoom = json['branchRoom'] != null
        ? Section.fromJson(json['branchRoom'])
        : null;
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
    if (branchRoom != null) {
      data['branchRoom'] = branchRoom!.toJson();
    }
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
    id = json['id'];
    info = json['info'];
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
