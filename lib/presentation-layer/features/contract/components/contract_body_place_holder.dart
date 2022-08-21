import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/core/extensions/widget_extension.dart';
import 'package:emekteb/presentation-layer/widgets/my_shimmer.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors/my_colors.dart';

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
            buildTablePlaceholder(context, 17),
            context.widget.verticalSpace(context, 0.03),
            buildTitlePlaceHolder(context),
            context.widget.verticalSpace(context, 0.015),
            buildTablePlaceholder(context, 4),
            context.widget.verticalSpace(context, 0.03),
            buildTitlePlaceHolder(context),
            context.widget.verticalSpace(context, 0.015),
            buildTablePlaceholder(context, 6),
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

  Widget buildTablePlaceholder(BuildContext context, int childCount) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: childCount,
      itemBuilder: (context, index) {
        return MyShimmer(
          color: MyColors.shimmerColor,
          child: Table(
            children: [
              TableRow(children: [
                Card(
                  child: Padding(
                    padding: context.paddingNormal,
                    child: const Text(""),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: context.paddingNormal,
                    child: const Text(""),
                  ),
                ),
              ]),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return context.widget.verticalSpace(context, 0.01);
      },
    );
  }
}
