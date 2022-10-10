import 'package:emekteb/data-domain/security/modules/chat_contact_controller.dart';
import 'package:emekteb/data-domain/security/modules/chat_message_from_controller.dart';

import '../../../../../core/init/network/IResponseModel.dart';
import '../../../utils/app/constants/enums/api_enum.dart';
import '../modules/chat_message_to_controller.dart';
import '../modules/login_response.dart';
import '../modules/user_info.dart';
import '../../../presentation/features/login/models/login.dart';

abstract class ISecurityService {
  Future<IResponseModel<LoginResponse>> fetchUser(Login model);

  Future<IResponseModel<UserInfo>> fetchUserInfo(String? accessToken);

  Future<IResponseModel<ChatMessageFromController>> fetchChatMessageFrom(
    String? accessToken,
    String? username,
    page,
    size,
  );

  Future<IResponseModel<ChatMessageFromController>>
      fetchChatMessageFromByMessageId(
    String? accessToken,
    String? username,
    String? messageId,
    CHAT_MESSAGE_SEARCH_TYPE chatMessageSearchType,
    page,
    size,
  );

  Future<IResponseModel<ChatMessageToController>> fetchChatMessageTo(
    String? accessToken,
    String? username,
    String? message,
  );

  Future<IResponseModel<List<ChatContactController>>> fetchChatContacts(
    String? accessToken,
  );
}
