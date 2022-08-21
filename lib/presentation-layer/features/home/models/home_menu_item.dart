import 'package:flutter/material.dart';

class HomeMenuItem {
  String route;
  IconData iconData;
  Color? iconColor;

  HomeMenuItem({
    required this.route,
    required this.iconData,
    this.iconColor,
  });
}
