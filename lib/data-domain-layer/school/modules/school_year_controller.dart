import 'package:emekteb/core/base/models/base_model.dart';

class SchoolYearController extends BaseModel<SchoolYearController> {
  String? code;
  String? message;
  Result? result;

  SchoolYearController({this.code, this.message, this.result});

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
  SchoolYearController fromJson(Map<String, dynamic> json) {
    return SchoolYearController(
      code: json['code'],
      message: json['message'],
      result: json['result'] != null ? Result.fromJson(json['result']) : null,
    );
  }
}

class Result {
  String? id;
  String? info;
  String? startYear;
  String? endYear;
  bool? isCurrent;
  int? statusYear;

  Result(
      {this.id,
      this.info,
      this.startYear,
      this.endYear,
      this.isCurrent,
      this.statusYear});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    info = json['info'];
    startYear = json['startYear'];
    endYear = json['endYear'];
    isCurrent = json['isCurrent'];
    statusYear = json['statusYear'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['info'] = info;
    data['startYear'] = startYear;
    data['endYear'] = endYear;
    data['isCurrent'] = isCurrent;
    data['statusYear'] = statusYear;
    return data;
  }
}
