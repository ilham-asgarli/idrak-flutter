import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';

import '../../core/constants/colors/my_colors.dart';
import 'my_shimmer.dart';

class TablePlaceHolder extends StatelessWidget {
  final int columnCount;
  final int rowCount;

  const TablePlaceHolder({
    required this.columnCount,
    required this.rowCount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: rowCount,
      itemBuilder: (context, index) {
        return MyShimmer(
          color: MyColors.shimmerColor,
          child: Table(
            children: [
              TableRow(
                children: List.generate(
                  columnCount,
                  (index) => Card(
                    child: Padding(
                      padding: context.paddingNormal,
                      child: const Text(""),
                    ),
                  ),
                ),
              ),
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
