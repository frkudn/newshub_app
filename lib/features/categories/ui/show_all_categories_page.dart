import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newshub/consts/news_categories.dart';
import 'package:newshub/view_model/news_view_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../models/news_channels_headlines_models.dart';
import '../../home/widgets/handle_headlines_image_url_null.dart';
import '../../home/widgets/headline_Image.dart';
import '../../home/widgets/headline_initial_loading.dart';
import '../../home/widgets/headlines_source_date.dart';
import '../../home/widgets/headlines_title.dart';
import '../../news/ui/news_page.dart';

class AllCategoriesPage extends ConsumerStatefulWidget {
  const AllCategoriesPage({
    super.key,
  });

  @override
  ConsumerState<AllCategoriesPage> createState() => _AllCategoriesPageState();
}

class _AllCategoriesPageState extends ConsumerState<AllCategoriesPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    ///********BUILD METHODS********////
    ///UpdateNews Category
    updateNewsCategory(String newsCategory) {
      if (kDebugMode) {
        print('Updating news category to: $newsCategory');
      }
      ref.read(newsCategoryStateProvider.notifier).state = newsCategory;
      if (kDebugMode) {
        print(
            'News category updated to: ${ref.read(newsCategoryStateProvider)}');
      }
      ref.invalidate(fetchCategoryNewsAPIProvider);

      print(
          "News Category changed to : ${ref.watch(newsCategoryStateProvider)}");
    }

    ///***fetchCategoryNewsAPIProvider***///
    final categoriesNewsData = ref.watch(fetchCategoryNewsAPIProvider);

    ///-------------------------------------------------------///

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          ///*************AppBar************///
          SliverAppBar(
            title: const Text("All Categories"),
            centerTitle: true,
            toolbarHeight: 6.h,
            collapsedHeight: 6.h,
            floating: true,
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 5.h),
              child: SizedBox(
                width: double.infinity,
                height: 6.h,
                // color: Colors.red,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _titleList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 1.w,
                    ),

                    ///TOP Categories Button on Pressed
                    child: GestureDetector(
                      onTap: () async {
                        final listTitle = newsCategoriesSourcesList[index];

                        ///Update News Category
                        updateNewsCategory(listTitle);

                        final showTitle = _titleList[index];
                        if (kDebugMode) {
                          print(showTitle);
                        }
                      },
                      child: Card(
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        elevation: 2,
                        child: Container(
                          alignment: Alignment.center,
                          height: 5.h,
                          width: _titleList[index].length.toDouble() * 14,
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          decoration: BoxDecoration(
                              color: ref.watch(newsCategoryStateProvider) ==
                                      newsCategoriesSourcesList[index]
                                  ? Colors.white
                                  : _colorsList[index],
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: ref.watch(newsCategoryStateProvider) ==
                                          newsCategoriesSourcesList[index]
                                      ? Colors.black
                                      : Colors.transparent)),
                          child: Text(
                            _titleList[index],
                            style: TextStyle(
                                color: ref.watch(newsCategoryStateProvider) ==
                                        newsCategoriesSourcesList[index]
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          /////****SLIVER APPBAR****///

          ///*************SliverList************///
          SliverList(
            delegate: SliverChildBuilderDelegate(
              addAutomaticKeepAlives: true,
              addRepaintBoundaries: true,
              (context, index) => categoriesNewsData.when(

                  ///Data is available
                  data: (data) {
                    // Check if data.articles is not null before accessing it

                    if (data.articles != null) {
                      return Scrollbar(
                        controller: _scrollController,
                        interactive: true,
                        thickness: 2.w,
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
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
                                      width: 96.w,
                                      height: 45.h,
                                    ),

                                    ///Headline Title
                                    HeadlinesTitle(
                                        headlineTitle: headlineTitle,
                                        width: 96.w),

                                    ///Source & Date
                                    HeadlinesSourceDate(
                                      publishAt:
                                          // You can also use predefined formats like 'yMMMd' for a short date format
                                          publishAt,
                                      sourceName: sourceName,
                                      width: 91.w,
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
                      );
                    } else {
                      // Handle the case where data.articles is null
                      return const Center(
                          child: Text("No articles available."));
                    }
                  },

                  ///Error
                  error: (error, stackTrace) => Center(
                      child: Image.asset("images/something_went_wrong.gif")),

                  ///Loading
                  loading: () => Center(
                    child: SizedBox(
                      height: 80.h,
                      child: SpinKitCircle(
                          size: 35.sp,
                          color: Colors.pink,
                        ),
                    ),
                  )),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  final List _titleList = [
    "General",
    "Entertainment",
    "Health",
    "Sports",
    "Business",
    "Technology",
  ];

  List<String> newsCategoriesSourcesList = [
    NewsCategories.general,
    NewsCategories.entertainment,
    NewsCategories.health,
    NewsCategories.sports,
    NewsCategories.business,
    NewsCategories.technology,
  ];

  final List<Color> _colorsList = [
    Colors.green.shade700,
    Colors.pink,
    Colors.blueAccent,
    Colors.amber,
    Colors.red,
    Colors.lightBlueAccent,
  ];
}
