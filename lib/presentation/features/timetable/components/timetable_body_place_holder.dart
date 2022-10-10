import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app/constants/colors/app_colors.dart';
import '../../../widgets/my_shimmer.dart';
import '../../../widgets/table_place_holder.dart';

class TimetableBodyPlaceHolder extends StatelessWidget {
  const TimetableBodyPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTitlePlaceHolder(context),
          context.widget.verticalSpace(context, 0.015),
          const TablePlaceHolder(
            columnCount: 2,
            rowCount: 8,
          ),
        ],
      ),
    );
  }

  Widget buildTitlePlaceHolder(BuildContext context) {
    return MyShimmer(
      color: AppColors.shimmerColor,
      child: SizedBox(
        width: context.dynamicWidth(0.5),
        height: context.dynamicHeight(0.05),
        child: const Card(),
      ),
    );
  }
}
