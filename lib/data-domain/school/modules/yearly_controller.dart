import '../../../core/base/models/base_model.dart';

class YearlyController extends BaseModel<YearlyController> {
  YearlyController({
    this.code,
    this.message,
    this.result,
  });

  String? code;
  String? message;
  List<Result>? result;

  @override
  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "result": result != null
            ? List<dynamic>.from(result!.map((x) => x.toJson()))
            : null,
      };

  @override
  YearlyController fromJson(Map<String, dynamic> json) {
    return YearlyController(
      code: json["code"],
      message: json["message"],
      result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    );
  }
}

class Result {
  Result({
    this.id,
    this.info,
    this.startYear,
    this.endYear,
    this.isCurrent,
    this.statusYear,
  });

  String? id;
  String? info;
  String? startYear;
  String? endYear;
  bool? isCurrent;
  int? statusYear;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        info: json["info"],
        startYear: json["startYear"],
        endYear: json["endYear"],
        isCurrent: json["isCurrent"],
        statusYear: json["statusYear"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "info": info,
        "startYear": startYear,
        "endYear": endYear,
        "isCurrent": isCurrent,
        "statusYear": statusYear,
      };
}
