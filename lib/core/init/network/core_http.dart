import 'dart:convert';
import 'dart:io';

import 'package:emekteb/core/base/models/base_http.dart';
import 'package:emekteb/core/constants/api/api_url_constants.dart';
import 'package:emekteb/core/helper/auth_helper.dart';
import 'package:http/http.dart';

import '../../base/models/base_error.dart';
import '../../base/models/base_model.dart';
import '../../constants/enums/http_request_enum.dart';
import '../../exceptions/network/http_exception.dart';
import 'IResponseModel.dart';

part './network_core/core_operations.dart';

class CoreHttp {
  static final CoreHttp _instance = CoreHttp._init();

  static CoreHttp get instance => _instance;

  CoreHttp._init();

  Future<IResponseModel<R>> send<R, T extends BaseModel>(
    String url, {
    required HttpTypes type,
    required T parseModel,
    data,
    accessToken,
  }) async {
    try {
      Response? response = await _sendRequest(
        url,
        type: type,
        data: data,
        accessToken: accessToken,
      );

      if (response != null) {
        try {
          final model = _returnResponse<R, T>(response, parseModel: parseModel);
          return ResponseModel<R>(data: model);
        } on InvalidInputException catch (e) {
          if (type == HttpTypes.GET) {
            await AuthHelper().logout();
          }
          return ResponseModel(error: BaseError(e.toString()));
        } on Exception catch (e) {
          return ResponseModel(error: BaseError(e.toString()));
        }
      } else {
        return ResponseModel(error: BaseError("Wrong http method"));
      }
    } on Exception catch (e) {
      return ResponseModel(error: BaseError(e.toString()));
    }
  }
}
