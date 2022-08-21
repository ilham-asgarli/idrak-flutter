import 'package:emekteb/core/base/notifier/base_change_notifier.dart';

class LoginNotifier extends BaseChangeNotifier {
  bool isPasswordVisible = false;
  bool isLogging = false;

  changeIsPasswordVisible(isPasswordVisible) {
    this.isPasswordVisible = isPasswordVisible;
    notifyListeners();
  }

  changeIsLogging(isLogging) {
    this.isLogging = isLogging;
    notifyListeners();
  }
}