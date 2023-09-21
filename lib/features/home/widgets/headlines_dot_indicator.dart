
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HeadlinesDotIndicators extends StatelessWidget {
  const HeadlinesDotIndicators({
    super.key,
    required this.dotsCount,
    required this.index,
  });

  final dotsCount;
  final index;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 15.w,
      left: 15.w,
      top: 2.h,
      child: Container(
        // margin: EdgeInsets.only(top: 1.5.h),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(40),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DotsIndicator(
            axis: Axis.horizontal,
            mainAxisSize: MainAxisSize.min,
            dotsCount: dotsCount ?? 2,
            position: index ?? 1,
            mainAxisAlignment: MainAxisAlignment.center,
            decorator: DotsDecorator(
                spacing: EdgeInsets.all(1.w),
                color: Colors.black, // Inactive color
                activeColor: Colors.amber,
                size: Size(1.5.w, 1.5.w)),
          ),
        ),
      ),
    );
  }
}
