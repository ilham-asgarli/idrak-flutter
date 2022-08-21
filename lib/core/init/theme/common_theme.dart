import 'package:emekteb/core/constants/colors/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonTheme {
  static final CommonTheme _instance = CommonTheme._init();

  static CommonTheme get instance => _instance;

  CommonTheme._init();

  ThemeData getTheme(ThemeData theme) {
    return theme.copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      //textTheme: Typography.tall2021.apply(fontSizeFactor: 1.sp),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MyColors.mainColor,
      ),
    );
  }
}
