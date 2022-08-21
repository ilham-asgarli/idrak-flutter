import 'dart:convert';

import 'package:emekteb/core/constants/app/hive_constants.dart';
import 'package:emekteb/data-domain-layer/security/modules/user_info.dart';
import 'package:flutter/material.dart';

import '../../../../core/base/view-models/base_view_model.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../core/init/navigation/navigation_service.dart';
import '../../../../core/init/network/IResponseModel.dart';
import '../../../../data-domain-layer/security/services/security_service.dart';
import '../../../../data-domain-layer/security/modules/login_response.dart';
import '../models/login.dart';
import '../notifiers/login_notifier.dart';

class LoginViewModel with BaseViewModel {
  late SecurityService loginService = SecurityService();
  late LoginNotifier loginNotifier;

  final Login loginModel = Login();

  Future<void> login() async {
    IResponseModel<LoginResponse> loginResponseModel =
        await loginService.fetchUser(loginModel);

    if (loginResponseModel.error != null) {
      ScaffoldMessenger.of(buildContext!).showSnackBar(
        SnackBar(
          content: Text(loginResponseModel.error?.message ?? ""),
        ),
      );
    }

    if (loginResponseModel.data != null) {
      IResponseModel<UserInfo> userInfoResponseModel = await loginService
          .fetchUserInfo(loginResponseModel.data?.result?.accessToken);

      await saveLocally(loginResponseModel.data!, userInfoResponseModel.data!);

      NavigationService.instance
          .navigateToPageClear(path: NavigationConstants.HOME);
    }
  }

  Future<void> saveLocally(
      LoginResponse loginResponse, UserInfo userInfoResponseModel) async {
    await hiveBox.put(
        HiveConstants.userModel, json.encode(loginResponse.toJson()));
    await hiveBox.put(
        HiveConstants.accessToken, loginResponse.result?.accessToken);
    await hiveBox.put(
        HiveConstants.refreshToken, loginResponse.result?.refreshToken);
    await hiveBox.put(HiveConstants.role, loginResponse.result?.user?.role);
    await hiveBox.put(HiveConstants.userInfoModel,
        json.encode(userInfoResponseModel.toJson()));
  }
}
