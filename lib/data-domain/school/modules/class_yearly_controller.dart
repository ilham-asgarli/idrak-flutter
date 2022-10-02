import 'package:emekteb/core/base/models/base_model.dart';
import 'package:emekteb/data-domain/school/modules/class_yearly_result_controller.dart';

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
          ? List<Result>.from(
              json["result"]
                  .map((x) => Result.fromJson(x)),
            )
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
