import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/core/extensions/widget_extension.dart';
import 'package:emekteb/presentation/features/chat/view-models/chat_init_view_model.dart';
import 'package:emekteb/utils/app/constants/colors/app_colors.dart';
import 'package:emekteb/utils/app/constants/navigation/navigation_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../models/home_grid.dart';

class HomeGridViewItem extends StatelessWidget {
  final HomeGrid homeGrid;

  const HomeGridViewItem({required this.homeGrid, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatInitViewModel chatInitViewModel =
        Provider.of<ChatInitViewModel>(context);

    return Card(
      color: context.theme.colorScheme.background,
      child: Padding(
        padding: context.paddingLow,
        child: Stack(
          children: [
            Center(
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
                        color: AppColors.secondColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible:
                  homeGrid.homeMenuItem.route == NavigationConstants.CHAT &&
                      chatInitViewModel.messageCount > 0,
              child: Positioned(
                top: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                  child: Text(
                    "${chatInitViewModel.messageCount < 100 ? chatInitViewModel.messageCount : "99+"}",
                    style: const TextStyle(
                      color: AppColors.secondColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
