import 'dart:convert';

import 'package:emekteb/utils/app/constants/cache/shared_preferences_constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../data-domain/security/modules/login_response.dart';
import '../../../data-domain/security/modules/user_info.dart';
import '../../../data-domain/security/services/security_service.dart';
import '../../../presentation/features/login/models/login.dart';
import '../constants/cache/hive_constants.dart';
import '../constants/navigation/navigation_constants.dart';
import '../../../core/init/cache/shared_preferences_manager.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../../../core/init/network/IResponseModel.dart';

class AuthHelper {
  SecurityService loginService = SecurityService();
  Box hiveBox = Hive.box(HiveConstants.userBox);

  Future<void> login({
    required BuildContext context,
    required bool mounted,
    required Login loginModel,
  }) async {
    IResponseModel<LoginResponse> loginResponseModel =
        await loginService.fetchUser(loginModel);

    if (loginResponseModel.error != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loginResponseModel.error?.message ?? ""),
        ),
      );
    }

    if (loginResponseModel.data != null) {
      IResponseModel<UserInfo> userInfoResponseModel = await loginService
          .fetchUserInfo(loginResponseModel.data?.result?.accessToken);

      await saveLoginDetailsLocally(
        loginResponseModel.data!,
        userInfoResponseModel.data!,
        loginModel,
      );

      NavigationService.instance
          .navigateToPageClear(path: NavigationConstants.HOME);
    }
  }

  Future<void> logout() async {
    await hiveBox.clear();
    NavigationService.instance
        .navigateToPageClear(path: NavigationConstants.LOGIN);
  }

  Future<void> saveLoginDetailsLocally(
    LoginResponse loginResponse,
    UserInfo userInfoResponseModel,
    Login loginModel,
  ) async {
    await hiveBox.put(
        HiveConstants.userModel, json.encode(loginResponse.toJson()));
    await hiveBox.put(HiveConstants.userInfoModel,
        json.encode(userInfoResponseModel.toJson()));
    await hiveBox.put(
        HiveConstants.accessToken, loginResponse.result?.accessToken);
    await hiveBox.put(
        HiveConstants.refreshToken, loginResponse.result?.refreshToken);
    await hiveBox.put(HiveConstants.role, loginResponse.result?.user?.role);

    await SharedPreferencesManager.instance.setStringValue(
        SharedPreferencesConstants.username, loginModel.username ?? "");
  }
}
