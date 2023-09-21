
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HeadlineImage extends StatelessWidget {
  const HeadlineImage({
    super.key,
    required this.imageUrl,required this.height,required this.width,
  });

  final imageUrl;
  final height;
  final width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: 0.7 .h, horizontal: 2.w),
      // height: 60.h,
      height: height,
      width: width,
      // width: 90.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: imageUrl,
           errorWidget: (context, url, error) => Center(child: Icon(Icons.error_outline),),
          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}