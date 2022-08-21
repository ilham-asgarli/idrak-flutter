import 'package:emekteb/presentation-layer/features/chat/views/chat_view.dart';
import 'package:emekteb/presentation-layer/features/contract/view/contract_details_view.dart';
import 'package:flutter/material.dart';

import '../../../presentation-layer/features/contract/model/contract_details.dart';
import '../../../presentation-layer/features/contract/view/contract_view.dart';
import '../../../presentation-layer/features/diary/views/diary_view.dart';
import '../../../presentation-layer/features/home/views/home_view.dart';
import '../../../presentation-layer/features/login/views/login_view.dart';
import '../../../presentation-layer/features/not-found-navigation/views/not_found_navigation.dart';
import '../../../presentation-layer/features/timetable/views/timetable_view.dart';
import '../../constants/navigation/navigation_constants.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();

  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationConstants.LOGIN:
        return normalNavigate(const LoginView(), NavigationConstants.LOGIN);
      case NavigationConstants.HOME:
        return normalNavigate(const HomeView(), NavigationConstants.HOME);
      case NavigationConstants.TIMETABLE:
        String title = settings.arguments as String;
        return normalNavigate(
            TimetableView(title: title), NavigationConstants.TIMETABLE);
      case NavigationConstants.DIARY:
        String title = settings.arguments as String;
        return normalNavigate(
            DiaryView(title: title), NavigationConstants.DIARY);
      case NavigationConstants.CONTRACT:
        String title = settings.arguments as String;
        return normalNavigate(
            ContractView(title: title), NavigationConstants.CONTRACT);
      case NavigationConstants.CONTRACT_DETAILS:
        ContractDetails contractDetails =
            settings.arguments as ContractDetails;
        return normalNavigate(
          ContractDetailsView(
            contractDetails: contractDetails,
          ),
          NavigationConstants.CONTRACT_DETAILS,
        );
      case NavigationConstants.CHAT:
        String title = settings.arguments as String;
        return normalNavigate(ChatView(title: title), NavigationConstants.CHAT);
      default:
        //throw NavigateException<SettingsDynamicModel>(args.arguments);
        return normalNavigate(
            const NotFoundNavigation(), NavigationConstants.NOT_FOUND);
    }
  }

  MaterialPageRoute normalNavigate(Widget widget, String pageName) {
    return MaterialPageRoute(
        builder: (context) => widget, settings: RouteSettings(name: pageName));
  }
}
