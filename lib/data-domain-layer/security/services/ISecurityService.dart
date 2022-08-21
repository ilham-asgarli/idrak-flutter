import '../../../../../core/init/network/IResponseModel.dart';
import '../modules/login_response.dart';
import '../modules/user_info.dart';
import '../../../presentation-layer/features/login/models/login.dart';

abstract class ISecurityService {
  Future<IResponseModel<LoginResponse>> fetchUser(Login model);
  Future<IResponseModel<UserInfo>> fetchUserInfo(String? accessToken);
}