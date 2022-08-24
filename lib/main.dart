import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:emekteb/core/constants/cache/hive_constants.dart';
import 'package:emekteb/core/init/cache/hive_manager.dart';
import 'package:emekteb/core/init/cache/shared_preferences_manager.dart';
import 'package:emekteb/generated/codegen_loader.g.dart';
import 'package:emekteb/presentation-layer/features/my-app/views/my_app_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'core/init/notifier/provider_list.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  await HiveManager.instance.openHiveBox(HiveConstants.userBox);
  await SharedPreferencesManager.preferencesInit();

  runApp(
    DevicePreview(
      enabled: false, //!kReleaseMode
      builder: (context) => EasyLocalization(
        supportedLocales: const [Locale('az', 'AZ')],
        path: 'assets/translations',
        assetLoader: const CodegenLoader(),
        startLocale: const Locale('az', 'AZ'),
        fallbackLocale: const Locale('en', 'US'),
        child: MultiProvider(
          providers: [...ApplicationProvider.instance.dependItems],
          child: const MyAppView(),
        ),
      ),
    ),
  );
}
