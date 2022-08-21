import 'package:emekteb/core/base/view-models/base_view_model.dart';
import 'package:emekteb/core/constants/app/hive_constants.dart';
import 'package:emekteb/core/constants/navigation/navigation_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app/shared_preferences_constants.dart';
import '../../../../core/init/notifier/theme_notifier.dart';

class MyAppViewModel with BaseViewModel {

  @override
  void init(context) async {
    super.init(context);
    await setTheme(context);
    FlutterNativeSplash.remove();
  }

  String getInitialRoute() {
    String? accessToken = hiveBox.get(HiveConstants.accessToken);

    if (accessToken == null) {
      return NavigationConstants.LOGIN;
    } else {
      return NavigationConstants.HOME;
    }
  }

  setTheme(context) async {
    ThemeNotifier themeNotifier = Provider.of(context);
    bool? isDarkMode = sharedPreferencesManager.getBoolValue(
      SharedPreferencesConstants.isDarkMode,
    );
    ThemeMode? themeMode = isDarkMode == null
        ? null
        : isDarkMode
            ? ThemeMode.dark
            : ThemeMode.light;
    themeNotifier.setThemeMode(themeMode);
  }
}
