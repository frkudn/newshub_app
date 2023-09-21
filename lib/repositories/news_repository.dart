import 'package:dio/dio.dart';
import 'package:newshub/models/news_channels_headlines_models.dart';

final dio = Dio();

class NewsRepository {
  Future<NewsChannelsHeadlineModel> fetchNewsChannelsHeadlinesAPI(
      source) async {
    String urlHeadlinesBySource =
        "https://newsapi.org/v2/top-headlines?${source}&apiKey=bfc36ba8ac6f41a8840d031f1ca67c60";

    final response = await dio.get(urlHeadlinesBySource);

    if (response.statusCode == 200) {
      return NewsChannelsHeadlineModel.fromJson(response.data);
    }
    throw DioExceptionType.connectionError;
  }



  Future<NewsChannelsHeadlineModel> fetchCategoriesNewsAPI(
      category) async {
    String urlHeadlinesBySource =
        "https://newsapi.org/v2/everything?q=${category}&apiKey=bfc36ba8ac6f41a8840d031f1ca67c60";

    final response = await dio.get(urlHeadlinesBySource);

    if (response.statusCode == 200) {
      return NewsChannelsHeadlineModel.fromJson(response.data);
    }
    throw DioExceptionType.connectionError;
  }
}
