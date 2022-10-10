import 'package:emekteb/utils/generics/constants/cache/shared_preferences_constants.dart';
import 'package:emekteb/utils/generics/helpers/auth_helper.dart';

import '../../../../core/base/view-models/base_view_model.dart';
import '../../../../core/init/cache/shared_preferences_manager.dart';
import '../models/login.dart';
import '../notifiers/login_notifier.dart';

class LoginViewModel with BaseViewModel {
  late LoginNotifier loginNotifier;

  final AuthHelper authHelper = AuthHelper();
  final Login loginModel = Login();

  String getSavedUserName() {
    return SharedPreferencesManager.instance
            .getStringValue(SharedPreferencesConstants.username) ??
        "";
  }
}
