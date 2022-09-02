import 'package:emekteb/core/constants/api/api_url_constants.dart';
import 'package:emekteb/core/constants/enums/http_request_enum.dart';
import 'package:emekteb/core/init/network/core_http.dart';
import 'package:emekteb/data-domain-layer/security/modules/chat_contact_controller.dart';
import 'package:emekteb/data-domain-layer/security/modules/chat_message_from_controller.dart';
import 'package:emekteb/data-domain-layer/security/modules/chat_message_to_controller.dart';
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

  @override
  Future<IResponseModel<List<ChatContactController>>> fetchChatContacts(
    String? accessToken,
  ) async {
    IResponseModel<List<ChatContactController>> response =
        await CoreHttp.instance.send(
      ApiUrlConstants.contacts,
      type: HttpTypes.GET,
      parseModel: ChatContactController(),
      accessToken: accessToken,
    );

    return response;
  }

  @override
  Future<IResponseModel<ChatMessageFromController>> fetchChatMessageFrom(
    String? accessToken,
    String? username,
    page,
    size,
  ) async {
    IResponseModel<ChatMessageFromController> response =
        await CoreHttp.instance.send(
      ApiUrlConstants.getMessage(username, page, size),
      type: HttpTypes.GET,
      parseModel: ChatMessageFromController(),
      accessToken: accessToken,
    );

    return response;
  }

  @override
  Future<IResponseModel<ChatMessageToController>> fetchChatMessageTo(
    String? accessToken,
    String? username,
    String? message,
  ) async {
    IResponseModel<ChatMessageToController> response =
        await CoreHttp.instance.send(
      ApiUrlConstants.message(username),
      type: HttpTypes.POST,
      parseModel: ChatMessageToController(),
      accessToken: accessToken,
      data: {"message": message},
    );

    return response;
  }
}
