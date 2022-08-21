import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class NotFoundNavigation extends StatelessWidget {
  const NotFoundNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            "403",
            style: context.textTheme.headline3,
          ),
        ),
      ),
    );
  }
}
