import 'package:emekteb/core/constants/colors/my_colors.dart';
import 'package:emekteb/core/extensions/context_extension.dart';
import 'package:emekteb/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';

import '../../../widgets/my_shimmer.dart';

class TimetableEndDrawerPlaceHolder extends StatelessWidget {
  const TimetableEndDrawerPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 15,
      itemBuilder: (context, index) {
        return MyShimmer(
          color: MyColors.shimmerColor,
          child: SizedBox(
            width: double.infinity,
            height: context.dynamicHeight(0.07),
            child: const Card(),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return context.widget.verticalSpace(context, 0.01);
      },
    );
  }
}
