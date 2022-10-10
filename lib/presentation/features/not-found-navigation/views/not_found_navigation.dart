import 'package:emekteb/generated/locale_keys.g.dart';
import 'package:emekteb/presentation/widgets/have_no.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotFoundNavigation extends StatelessWidget {
  const NotFoundNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: HaveNo(
            description: LocaleKeys.notFoundNavigation,
            iconData: FontAwesomeIcons.ban,
          ),
        ),
      ),
    );
  }
}
