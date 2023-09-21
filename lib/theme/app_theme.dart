import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppTheme {
  static final ThemeData light = ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    scrollbarTheme: ScrollbarThemeData(
      radius: const Radius.circular(30),
      interactive: true,
      thumbColor: MaterialStateProperty.all(Colors.amber),
      trackColor: MaterialStateProperty.all(Colors.black),
      crossAxisMargin: 2.h,
      minThumbLength: 25.w,
      trackVisibility: MaterialStateProperty.all(true),
      mainAxisMargin: 3.w,
    ),
    scaffoldBackgroundColor: Colors.white,
  );

  static final ThemeData darkMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.black));

}
