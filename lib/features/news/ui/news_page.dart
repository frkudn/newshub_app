import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewsPage extends StatelessWidget {
  NewsPage(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.content,
      required this.sourceName,
      required this.author});

  String imageUrl;
  String title;
  String content;
  String author;
  String sourceName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          ///Sliver AppBar & Image
          SliverAppBar(
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: const Icon(CupertinoIcons.left_chevron, color: Colors.white,)),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  sourceName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      shadows: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2,
                          spreadRadius: 3,
                        )
                      ]),
                ),
              )
            ],
            collapsedHeight: 10.0.h,
            expandedHeight: 40.0.h,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),

          ///Author
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(left: 2.w),
              color: Colors.red,
              child: Text(
                "By: $author",
                style: GoogleFonts.robotoCondensed(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),


          ///Title
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.8.h),
              child: Text(
                title,
                style: GoogleFonts.roboto(
                    fontSize: 21.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          ///Content
          SliverToBoxAdapter(
            child: Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric( horizontal: 2.w),
                  child: Text(
                    content,
                    style: GoogleFonts.poppins(fontSize: 18.sp),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
