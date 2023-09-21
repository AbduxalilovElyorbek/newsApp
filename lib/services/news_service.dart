import 'dart:convert';

import 'package:news_app/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/utils/either.dart';

class AppService {
  String token = "c4cd9a86d4f742868af5b84bb0b1c1a9";

  Future<Either<String, List<NewsModel>>> getNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=$token";

    try {
      var res = await http.get(
        Uri.parse(url),
      );

      print(res.statusCode);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        var data = jsonDecode(res.body);
        var data1 = (data['articles'] as List<dynamic>);
        final list = data1.map((e) {
          return NewsModel.fromJson(e);
        }).toList();

        return Right(list);
      }
      return Left("Internet bilan bog'lanishdagi xatolik");
    } catch (e) {
      return Left("${e.toString()}");
    }
  }

  Future<Either<String, List<NewsModel>>> searchNews(
      {required String text}) async {
    String search =
        "https://newsapi.org/v2/everything?q=$text&sortBy=publishedAt&language=en&apiKey=$token";

    try {
      var res = await http.get(
        Uri.parse(search),
      );

      print(res.statusCode);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        var data = jsonDecode(res.body);
        var data1 = (data['articles'] as List<dynamic>);
        final list = data1.map((e) {
          return NewsModel.fromJson(e);
        }).toList();

        return Right(list);
      }
    } catch (e) {
      return Left(e.toString());
    }

    return Left("Server Error");
  }
}
