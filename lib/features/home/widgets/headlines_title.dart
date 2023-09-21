import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HeadlinesTitle extends StatelessWidget {
  const HeadlinesTitle({
    super.key,
    required this.headlineTitle,required this.width,
  });

  final String? headlineTitle;
  final width;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 6.3.h,
      left: 1.6.w,
      child: SizedBox(
          // width: 90.w,
        width: width,
          child: Card(
            color: Colors.transparent,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20)),
            elevation: 2,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius:
                  BorderRadius.circular(20)),
              child: Text(
                headlineTitle!,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                    fontSize: 16.sp),
              ),
            ),
          )),
    );
  }
}
