import 'package:emekteb/core/base/models/base_model.dart';

class SchoolWeekYearly extends BaseModel {
  String? code;
  String? message;
  List<Result>? result;

  SchoolWeekYearly({this.code, this.message, this.result});

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

  @override
  fromJson(Map<String, dynamic> json) {
    return SchoolWeekYearly(
      code: json['code'],
      message: json['message'],
      result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    );
  }
}

class Result {
  int? id;
  String? info;
  String? startWeek;
  String? endWeek;
  bool? isCurrent;

  Result({this.id, this.info, this.startWeek, this.endWeek, this.isCurrent});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    info = json['info'];
    startWeek = json['startWeek'];
    endWeek = json['endWeek'];
    isCurrent = json['isCurrent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['info'] = info;
    data['startWeek'] = startWeek;
    data['endWeek'] = endWeek;
    data['isCurrent'] = isCurrent;
    return data;
  }
}
