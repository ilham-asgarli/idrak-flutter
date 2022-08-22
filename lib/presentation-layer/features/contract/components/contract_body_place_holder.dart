import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/core/extensions/widget_extension.dart';
import 'package:emekteb/presentation-layer/widgets/my_shimmer.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors/my_colors.dart';
import '../../../widgets/table_place_holder.dart';

class ContractBodyPlaceHolder extends StatelessWidget {
  const ContractBodyPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: context.paddingNormal,
        child: Column(
          children: [
            buildTitlePlaceHolder(context),
            context.widget.verticalSpace(context, 0.015),
            const TablePlaceHolder(
              columnCount: 2,
              rowCount: 17,
            ),
            context.widget.verticalSpace(context, 0.03),
            buildTitlePlaceHolder(context),
            context.widget.verticalSpace(context, 0.015),
            const TablePlaceHolder(
              columnCount: 2,
              rowCount: 4,
            ),
            context.widget.verticalSpace(context, 0.03),
            buildTitlePlaceHolder(context),
            context.widget.verticalSpace(context, 0.015),
            const TablePlaceHolder(
              columnCount: 2,
              rowCount: 6,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTitlePlaceHolder(BuildContext context) {
    return MyShimmer(
      color: MyColors.shimmerColor,
      child: SizedBox(
        width: context.dynamicWidth(0.5),
        height: context.dynamicHeight(0.04),
        child: const Card(),
      ),
    );
  }
}
