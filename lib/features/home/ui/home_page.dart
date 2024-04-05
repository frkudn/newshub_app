// ignore_for_file: unused_result

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newshub/consts/news_sources.dart';
import 'package:newshub/consts/images.dart';
import 'package:newshub/features/categories/ui/show_all_categories_page.dart';
import 'package:newshub/features/home/widgets/custom_navigation_drawer.dart';
import 'package:newshub/features/news/ui/news_page.dart';
import 'package:newshub/models/news_channels_headlines_models.dart';
import 'package:newshub/view_model/news_view_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../widgets/home_general_category_news_section.dart';
import '../widgets/handle_headlines_image_url_null.dart';
import '../widgets/headline_Image.dart';
import '../widgets/headline_initial_loading.dart';
import '../widgets/headlines_dot_indicator.dart';
import '../widgets/headlines_source_date.dart';
import '../widgets/headlines_title.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final newsSources = NewsSources();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    ///******Providers Inside the Build **********
    final headlinesNewsData = ref.watch(fetchNewsChannelHeadlinesAPIProvider);
    final categoriesNewsData = ref.watch(fetchCategoryNewsAPIProvider);

    ///---------------------------------------------------------/////

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title:
            SizedBox(height: 8.h, child: Image.asset("images/newshublogo.png")),
        centerTitle: true,
        leading: const DrawerButton(),
        actions: [
          selectNewsSourceIcon(context),
        ],
      ),

      ///Drawer
      drawer: const CustomNavDrawer(),

      ///body
      body: SizedBox(
        // color: Colors.amber,
        height: 100.h,
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: ListView(
            children: [
              ///***Headlines News Section****///
              headlineNewsSection(headlinesNewsData),

              ///***Categories***///
              ///Heading///
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllCategoriesPage(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Show Categories >",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 20.sp),
                  ),
                ),
              ),

              ///General Category News Section
              HomeGeneralCategoryNewsSection(
                  categoriesNewsData: categoriesNewsData),

              ///**************************///
            ],
          ),
        ),
      ),
    );
  }

  ///************Methods********///

  ///AppBar Select News Source Button
  IconButton selectNewsSourceIcon(BuildContext context) {
    return IconButton(
        onPressed: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            context: context,
            builder: (context) => SizedBox(
              height: 8.h,
              width: 100.w,
              child: Row(
                children: [
                  ///News Icons
                  SizedBox(
                    width: 85.w,
                    child: ListView(
                      shrinkWrap: true,
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      children: [
                        ///Ary News
                        customIconButton(
                            image: AppImages.aryNews,
                            newsSource: newsSources.aryNews),

                        ///ABC New
                        customIconButton(
                            image: AppImages.abcNews,
                            newsSource: newsSources.abcNews),

                        ///Al-Jazeera
                        customIconButton(
                            image: AppImages.alJazeera,
                            newsSource: newsSources.aljaziraNews),

                        ///BBC News
                        customIconButton(
                            image: AppImages.bbcNews,
                            newsSource: newsSources.bbcNews),

                        ///BBC Sports
                        customIconButton(
                            image: AppImages.bbcSports,
                            newsSource: newsSources.bbcSportsNews),

                        ///Buzzfeed
                        customIconButton(
                            image: AppImages.buzzfeed,
                            newsSource: newsSources.buzzfeed),

                        ///Bloomberg News
                        customIconButton(
                            image: AppImages.bloombergNews,
                            newsSource: newsSources.bloombergNews),

                        ///CBC News
                        customIconButton(
                            image: AppImages.cbcNews,
                            newsSource: newsSources.cbcNews),

                        ///CNN News
                        customIconButton(
                            image: AppImages.cnnNews,
                            newsSource: newsSources.cnnNews),

                        ///ESPN
                        customIconButton(
                            image: AppImages.espn,
                            newsSource: newsSources.espnNews),

                        ///Fortune
                        customIconButton(
                            image: AppImages.fortune,
                            newsSource: newsSources.fortune),

                        ///FOX News
                        customIconButton(
                            image: AppImages.foxnews,
                            newsSource: newsSources.foxNews),

                        ///Google News
                        customIconButton(
                            image: AppImages.googleNews,
                            newsSource: newsSources.googleNews),

                        ///Reuters News
                        customIconButton(
                            image: AppImages.reuters,
                            newsSource: newsSources.reuters),
                      ],
                    ),
                  ),

                  ///Next Circle Icon
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: CircleAvatar(
                        radius: 5.w,
                        backgroundColor: Colors.black,
                        child: IconButton(
                          icon: const Icon(
                            CupertinoIcons.right_chevron,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _scrollOneStepToRight();
                          },
                        )),
                  )
                ],
              ),
            ),
          );
        },
        icon:
            SizedBox(height: 5.h, child: Image.asset("images/updatenews.png")));
  }

  /// ScrollOneStepToRight
  void _scrollOneStepToRight() {
    try {
      _scrollController.animateTo(
        _scrollController.offset + 200, // Adjust the value as needed
        curve: Curves.linear,
        duration:
            const Duration(milliseconds: 500), // Adjust the duration as needed
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error scrolling: $e');
      }
    }
  }

  ///Custom Icon Button
  IconButton customIconButton({newsSource, image}) {
    return IconButton(
      onPressed: () {
        updateNews(newsSource);
      },
      icon: Image.asset(image),
    );
  }

  ///Custom GridTile
  GridTile customGridTile({final image, final news}) {
    return GridTile(
      child: GestureDetector(
        onTap: () {
          news;
        },
        child: Image.asset(image),
      ),
    );
  }

  ///RefreshData
  Future<void> _refreshData() async {
    // Trigger the data fetching logic here by reading the provider again
    ref.refresh(fetchNewsChannelHeadlinesAPIProvider);
    ref.refresh(fetchCategoryNewsAPIProvider);
  }

  ///***Headlines News Section****///
  headlineNewsSection(AsyncValue<NewsChannelsHeadlineModel> newsData) {
    return SizedBox(
        // color: Colors.amber,
        height: 60.h,
        width: 100.w,
        child: newsData.when(

            ///Data is available
            data: (data) {
              // Check if data.articles is not null before accessing it

              if (data.articles != null) {
                return SizedBox(
                  child: ListView.builder(
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
                                ));
                          },
                          child: Stack(
                            children: [
                              ///Image
                              HeadlineImage(
                                imageUrl: imageUrl,
                                height: 60.h,
                                width: 90.w,
                              ),

                              ///Headline Title
                              HeadlinesTitle(
                                headlineTitle: headlineTitle,
                                width: 90.w,
                              ),

                              ///Source & Date
                              HeadlinesSourceDate(
                                publishAt:
                                    // You can also use predefined formats like 'yMMMd' for a short date format
                                    publishAt,
                                sourceName: sourceName,
                                width: 85.w,
                              ),

                              ///Dots Indicators
                              HeadlinesDotIndicators(
                                  dotsCount: data.articles?.length,
                                  index: index),
                            ],
                          ),
                        );
                      } else {
                        /// Handle the case where imageUrl is null
                        return const HandleImageURLisNull();
                      }
                    },
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

  ///UpdateNews
  updateNews(String newsSource) {
    ref.read(newsSourceStateProvider.notifier).state = newsSource;
    ref.refresh(fetchNewsChannelHeadlinesAPIProvider);
  }
}




// applicationId "com.furqanuddin.newshub.newshub"