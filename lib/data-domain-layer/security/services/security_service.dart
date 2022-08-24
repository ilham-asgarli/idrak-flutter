import 'package:emekteb/core/constants/api/api_url_constants.dart';
import 'package:emekteb/core/constants/enums/http_request_enum.dart';
import 'package:emekteb/core/init/network/core_http.dart';
import 'package:emekteb/data-domain-layer/security/modules/login_response.dart';
import 'package:emekteb/data-domain-layer/security/modules/user_info.dart';

import '../../../core/init/network/IResponseModel.dart';
import '../../../presentation-layer/features/login/models/login.dart';
import 'ISecurityService.dart';

class SecurityService extends ISecurityService {
  @override
  Future<IResponseModel<LoginResponse>> fetchUser(Login model) async {
    IResponseModel<LoginResponse> response =
        await CoreHttp.instance.send<LoginResponse, LoginResponse>(
      ApiUrlConstants.auth,
      type: HttpTypes.POST,
      parseModel: LoginResponse(),
      data: model.toJson(),
    );

    return response;
  }

  @override
  Future<IResponseModel<UserInfo>> fetchUserInfo(String? accessToken) async {
    IResponseModel<UserInfo> response = await CoreHttp.instance.send(
      ApiUrlConstants.userInfo,
      type: HttpTypes.GET,
      parseModel: UserInfo(),
      accessToken: accessToken,
    );

    return response;
  }
}
