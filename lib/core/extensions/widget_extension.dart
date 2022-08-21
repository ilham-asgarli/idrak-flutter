import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget get toSliver {
    return SliverToBoxAdapter(child: this);
  }

  Widget verticalSpace(BuildContext context, double val) => SizedBox(
        height: context.dynamicHeight(val),
      );

  Widget horizontalSpace(BuildContext context, double val) => SizedBox(
    width: context.dynamicWidth(val),
  );
}
