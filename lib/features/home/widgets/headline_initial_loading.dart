


import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HeadlineIntialLoading extends StatelessWidget {
  const HeadlineIntialLoading({
    super.key, this.scrollDirection = Axis.horizontal,
  });

  final scrollDirection;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: scrollDirection,
      padding: EdgeInsets.zero,
      itemCount: 10,
      itemBuilder: (context, index) =>  Container(
        margin: const EdgeInsets.all(8),
        height: 60.h,
        width: 90.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.black,width: 1,style: BorderStyle.solid,strokeAlign:BorderSide.strokeAlignOutside )
        ),
        child: const SpinKitCircle(
          size: 50,
          color: Colors.purple,
        )),);
  }
}