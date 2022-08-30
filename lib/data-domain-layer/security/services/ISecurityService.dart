import 'package:emekteb/data-domain-layer/security/modules/chat_contact_controller.dart';
import 'package:emekteb/data-domain-layer/security/modules/chat_message_from_controller.dart';

import '../../../../../core/init/network/IResponseModel.dart';
import '../modules/login_response.dart';
import '../modules/user_info.dart';
import '../../../presentation-layer/features/login/models/login.dart';

abstract class ISecurityService {
  Future<IResponseModel<LoginResponse>> fetchUser(Login model);

  Future<IResponseModel<UserInfo>> fetchUserInfo(String? accessToken);

  Future<IResponseModel<List<ChatMessageFromController>>> fetchChatMessageFrom(
    String? accessToken,
    String? username,
  );

  Future<IResponseModel<List<ChatContactController>>> fetchChatContacts(
    String? accessToken,
  );
}
