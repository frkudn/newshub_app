import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../models/news_channels_headlines_models.dart';
import '../../news/ui/news_page.dart';
import 'handle_headlines_image_url_null.dart';
import 'headline_Image.dart';
import 'headline_initial_loading.dart';
import 'headlines_dot_indicator.dart';
import 'headlines_source_date.dart';
import 'headlines_title.dart';

class HomeGeneralCategoryNewsSection extends StatelessWidget {
  const HomeGeneralCategoryNewsSection({
    super.key,
    required this.categoriesNewsData,
  });

  final AsyncValue<NewsChannelsHeadlineModel> categoriesNewsData;



  @override
  Widget build(BuildContext context) {

    final ScrollController scrollController = ScrollController();
    return SizedBox(
        // color: Colors.amber,
        height: 45.h,
        width: 40.w,
        child: categoriesNewsData.when(

            ///Data is available
            data: (data) {
              // Check if data.articles is not null before accessing it

              if (data.articles != null) {
                return  Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  thickness: 2.h,
                  trackVisibility: true,
                  radius: const Radius.circular(30),
                  interactive: true,
                  child: Padding(
                    padding:  EdgeInsets.only(bottom: 6.h),
                    child: ListView.builder(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: data.articles!.length,
                      itemBuilder: (context, index) {
                        ///Article
                        final article = data.articles![index];

                        ///ImageUrl
                        final imageUrl = article.urlToImage;

                        ///Headlines
                        String? headlineTitle = article.title ?? "";

                        ///Source
                        String? sourceName = article.source?.name ?? "";

                        ///Content
                        String? content = article.content ?? "";

                        ///Author
                        String? author = article.author ?? "";

                        ///PublishedAt
                        // Assuming publishAt is a String representing a date and time
                        final String publishAt = article.publishedAt ?? "";

                        ///Description

                        if (imageUrl != null) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsPage(
                                    imageUrl: imageUrl,
                                    title: headlineTitle,
                                    content: content,
                                    sourceName: sourceName,
                                    author: author,
                                  ),
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                ///Image
                                HeadlineImage(
                                  imageUrl: imageUrl,
                                  width: 70.w,
                                  height: 45.h,
                                ),

                                ///Headline Title
                                HeadlinesTitle(headlineTitle: headlineTitle, width: 70.w),

                                ///Source & Date
                                HeadlinesSourceDate(
                                  publishAt:
                                  // You can also use predefined formats like 'yMMMd' for a short date format
                                  publishAt,
                                  sourceName: sourceName,
                                  width: 68.w,
                                ),
                              ],
                            ),
                          );
                        } else {
                          /// Handle the case where imageUrl is null
                          return const HandleImageURLisNull();
                        }
                      },
                    ),
                  ),
                );
              } else {
                // Handle the case where data.articles is null
                return const Center(child: Text("No articles available."));
              }
            },

            ///Error
            error: (error, stackTrace) =>
                Center(child: Image.asset("images/something_went_wrong.gif")),

            ///Loading
            loading: () => const HeadlineIntialLoading()));
  }
}
