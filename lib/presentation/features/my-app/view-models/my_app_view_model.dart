import 'package:emekteb/core/base/view-models/base_view_model.dart';
import 'package:emekteb/utils/generics/constants/cache/hive_constants.dart';
import 'package:emekteb/utils/generics/constants/navigation/navigation_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import '../../../../utils/generics/constants/cache/shared_preferences_constants.dart';
import '../../../../utils/generics/notifier/theme_notifier.dart';

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
