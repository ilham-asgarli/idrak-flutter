import 'package:emekteb/presentation-layer/features/chat/views/chat_view.dart';
import 'package:emekteb/presentation-layer/features/chat/views/chats_view.dart';
import 'package:emekteb/presentation-layer/features/contract/models/contract_model.dart';
import 'package:emekteb/presentation-layer/features/contract/views/contract_details_view.dart';
import 'package:emekteb/presentation-layer/features/contract/views/contracts_view.dart';
import 'package:flutter/material.dart';

import '../../../data-domain-layer/security/modules/chat_contact_controller.dart';
import '../../../presentation-layer/features/contract/models/contract_details.dart';
import '../../../presentation-layer/features/contract/views/contract_view.dart';
import '../../../presentation-layer/features/timetable/views/timetable_view.dart';
import '../../../presentation-layer/features/home/views/home_view.dart';
import '../../../presentation-layer/features/login/views/login_view.dart';
import '../../../presentation-layer/features/not-found-navigation/views/not_found_navigation.dart';
import '../../../presentation-layer/features/schedule/views/schedule_view.dart';
import '../../constants/navigation/navigation_constants.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();

  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationConstants.LOGIN:
        return normalNavigate(
          const LoginView(),
          NavigationConstants.LOGIN,
        );
      case NavigationConstants.HOME:
        return normalNavigate(
          const HomeView(),
          NavigationConstants.HOME,
        );
      case NavigationConstants.SCHEDULE:
        String title = settings.arguments as String;
        return normalNavigate(
          ScheduleView(title: title),
          NavigationConstants.SCHEDULE,
        );
      case NavigationConstants.TIMETABLE:
        String title = settings.arguments as String;
        return normalNavigate(
          TimetableView(title: title),
          NavigationConstants.TIMETABLE,
        );
      case NavigationConstants.CONTRACTS:
        if(settings.arguments is ContractModel) {
          return normalNavigate(
            ContractView(contractModel: settings.arguments as ContractModel),
            NavigationConstants.CONTRACT,
          );
        } else {
          return normalNavigate(
            ContractsView(title: settings.arguments as String),
            NavigationConstants.CONTRACTS,
          );
        }
      case NavigationConstants.CONTRACT_DETAILS:
        ContractDetails contractDetails = settings.arguments as ContractDetails;
        return normalNavigate(
          ContractDetailsView(
            contractDetails: contractDetails,
          ),
          NavigationConstants.CONTRACT_DETAILS,
        );
      case NavigationConstants.CHAT:
        String title = settings.arguments as String;
        return normalNavigate(
          ChatsView(title: title),
          NavigationConstants.CHAT,
        );
      case NavigationConstants.CHAT_ITEM:
        ChatContactController chatContactController =
            settings.arguments as ChatContactController;
        return normalNavigate(
          ChatView(chatContactController: chatContactController),
          NavigationConstants.CHAT_ITEM,
        );
      default:
        //throw NavigateException<SettingsDynamicModel>(args.arguments);
        return normalNavigate(
          const NotFoundNavigation(),
          NavigationConstants.NOT_FOUND,
        );
    }
  }

  MaterialPageRoute normalNavigate(Widget widget, String pageName) {
    return MaterialPageRoute(
        builder: (context) => widget, settings: RouteSettings(name: pageName));
  }
}
