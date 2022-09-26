import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HaveNo extends StatelessWidget {
  final IconData iconData;
  final String description;

  const HaveNo({
    required this.description,
    required this.iconData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            iconData,
            size: 100,
            color: context.colorScheme.background,
          ),
          context.widget.verticalSpace(context, 0.05),
          Text(
            description,
            style: TextStyle(
              color: context.colorScheme.background,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
