import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HandleImageURLisNull extends StatelessWidget {
  const HandleImageURLisNull({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: 45.w,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: CachedNetworkImage(
            imageUrl: "https://csshint.com/wp-content/uploads/2019/06/HTML-Funny-404-Pages.gif",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
