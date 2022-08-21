import 'package:emekteb/core/constants/colors/my_colors.dart';
import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/home_grid.dart';

class HomeGridViewItem extends StatelessWidget {
  final HomeGrid homeGrid;

  const HomeGridViewItem({required this.homeGrid, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.theme.colorScheme.background,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              homeGrid.homeMenuItem.iconData,
              color: homeGrid.homeMenuItem.iconColor,
            ),
            context.widget.horizontalSpace(context, 0.03),
            Flexible(
              child: Text(
                homeGrid.title,
                textAlign: TextAlign.center,
                style: context.textTheme.titleMedium!.copyWith(
                  color: MyColors.secondColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
