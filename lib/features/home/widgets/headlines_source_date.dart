import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HeadlinesSourceDate extends StatelessWidget {
  HeadlinesSourceDate(
      {super.key, required this.publishAt, required this.sourceName,required this.width});


  final publishAt;
  final sourceName;
  final width;

  // Example output: Sep 20, 2023
  @override
  Widget build(BuildContext context) {
    final articleDate = DateTime.parse(publishAt);
    // Format the DateTime to a short date format (e.g., Sep 20, 2023)
    String shortFormattedDate = DateFormat.yMMMd().format(articleDate);

    return Positioned(
      bottom: 1.6.h,
      left: 5.w,
      child: SizedBox(
          // width: 85.w,
        width: width,
          child: Container(
            padding: EdgeInsets.all(3.w),
            // margin: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.w),
            decoration: BoxDecoration(
                color: Colors.black54, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Source Name
                Text(
                  sourceName!,
                  style:
                      GoogleFonts.poppins(fontSize: 13.sp, color: Colors.white),
                ),

                ///Date
                Text(shortFormattedDate,  style: GoogleFonts.aBeeZee(
            fontSize: 13.sp,
            color: Colors.white),
                ),
              ],
            ),
          )),
    );
  }
}
