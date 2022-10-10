import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/home_menu_item.dart';
import '../../../../utils/app/constants/navigation/navigation_constants.dart';

class Constants {
  static List<HomeMenuItem> homeMenuItems = [
    HomeMenuItem(
      route: NavigationConstants.SCHEDULE,
      iconData: FontAwesomeIcons.list,
      iconColor: Colors.orange,
    ),
    HomeMenuItem(
      route: NavigationConstants.TIMETABLE,
      iconData: FontAwesomeIcons.book,
      iconColor: Colors.teal,
    ),
    HomeMenuItem(
      route: NavigationConstants.CHAT,
      iconData: FontAwesomeIcons.rocketchat,
      iconColor: Colors.green,
    ),
    HomeMenuItem(
      route: NavigationConstants.CONTRACTS,
      iconData: FontAwesomeIcons.handshake,
      iconColor: Colors.blue,
    ),
  ];
}
