import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/generics/constants/colors/my_colors.dart';

class MyShimmerFromColor extends StatelessWidget {
  final Widget child;
  const MyShimmerFromColor({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: MyColors.shimmerBaseColor,
      highlightColor: MyColors.shimmerHighLightColor,
      enabled: true,
      child: child,
    );
  }
}
