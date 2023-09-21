import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newshub/consts/news_categories.dart';
import 'package:newshub/consts/news_sources.dart';
import 'package:newshub/models/news_channels_headlines_models.dart';
import 'package:newshub/repositories/news_repository.dart';

class NewsViewModel {
  final _repo = NewsRepository();

  ///News Sources
  Future<NewsChannelsHeadlineModel> fetchNewsChannelsHeadlinesAPI(source) async {
    final response = await _repo.fetchNewsChannelsHeadlinesAPI(source);
    return response;
  }


  ///Categories
  Future<NewsChannelsHeadlineModel> fetchCategoriesNewsAPI(category) async {
    final response = await _repo.fetchCategoriesNewsAPI(category);
    return response;
  }
}


///****Define Provider****///
///newsViewModelProvider
final newsViewModel = Provider<NewsViewModel>((ref) => NewsViewModel());


///News Source
final newsSourceStateProvider = StateProvider<String>((ref) {
  final newsSource = NewsSources();
  return newsSource.bbcNews;
});

///fetchNewsChannelHeadlinesAPIProvider
final fetchNewsChannelHeadlinesAPIProvider = FutureProvider((ref) {
  return ref.read(newsViewModel).fetchNewsChannelsHeadlinesAPI(ref.watch(newsSourceStateProvider));
});


///Categories Provider
final newsCategoryStateProvider = StateProvider<String>((ref) {
  // final newsCategory = NewsCategories();
  return NewsCategories.general;
});


///fetchNewsChannelHeadlinesAPIProvider
final fetchCategoryNewsAPIProvider = FutureProvider((ref) {
  return ref.read(newsViewModel).fetchCategoriesNewsAPI(ref.watch(newsCategoryStateProvider));
});




