import 'dart:convert';

import 'package:emekteb/core/constants/cache/hive_constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../utils/constants/enums/enums.dart';
import '../../init/cache/shared_preferences_manager.dart';
import '../../init/navigation/navigation_service.dart';

abstract class BaseViewModel {
  BuildContext? buildContext;

  SharedPreferencesManager sharedPreferencesManager =
      SharedPreferencesManager.instance;
  NavigationService navigation = NavigationService.instance;
  Box hiveBox = Hive.box(HiveConstants.userBox);

  Map<String, dynamic>? userModel;
  Map<String, dynamic>? userInfoModel;
  String? accessToken;
  ROLE? role;

  /// If you want to set user info before screen created call super.init(); first at override on init function
  void init(context) {
    setBuildContext(context);
    setUserInfo();
  }

  void setBuildContext(BuildContext context) {
    buildContext = context;
  }

  void setUserInfo() {
    accessToken = hiveBox.get(HiveConstants.accessToken);
    role = getRoleFromString(hiveBox.get(HiveConstants.role));
    userModel = jsonDecode(hiveBox.get(HiveConstants.userModel, defaultValue: "{}"));
    userInfoModel = jsonDecode(hiveBox.get(HiveConstants.userInfoModel, defaultValue: "{}"));
  }

  ROLE? getRoleFromString(String? role) {
    for (ROLE r in ROLE.values) {
      if (r.name == role) {
        return r;
      }
    }
    return null;
  }
}
