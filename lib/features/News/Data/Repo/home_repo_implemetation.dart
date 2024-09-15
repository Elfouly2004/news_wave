
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/features/News/Data/Model/News_model.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/endpoints.dart';
import 'home_repo.dart';

class HomeRepoImplementationFromApi implements HomeRepo {
  @override
  Future<Either<Failure, List<NewsModel>>> getTopHeadline({required String category}) async {

    List<NewsModel> news = [] ;

    try {
      var response = await http.get(Uri.parse(
          "${EndPoints.baseUrl}${EndPoints.getTopHeadlineEndpoint}?apiKey=${EndPoints.apiKey}&category=$category"));

      if(response.statusCode == 200) {
        for (var article in jsonDecode(response.body)["articles"]) {
          NewsModel newModel = NewsModel(
              title: article["title"],
              desc: article["description"],
              content: article["content"],
              urlToImage: article["urlToImage"],
              url: article["url"],
              publishedAt: article["publishedAt"],
              sourceModel: SourceModel(id: article["source"]["id"], name:  article["source"]["name"]));

          news.add(newModel);
        }
        return right(news);
      }else{

        return left( ApiFailure(message: jsonDecode(response.body)["message"]));

      }


    } catch (e) {
      debugPrint(e.toString());
      return left(ApiFailure(message: "Oops error occurred!"));
    }
  }






  @override
  Future<Either<Failure, List<NewsModel>>> searchForNews({required String q})async {

    List<NewsModel> news = [] ;

    try {
      var response = await http.get(Uri.parse(
          "${EndPoints.baseUrl}${EndPoints.searchAboutNews}?q=$q&apiKey=${EndPoints.apiKey}"));

      if(response.statusCode == 200) {
        for (var article in jsonDecode(response.body)["articles"]) {
          NewsModel newModel = NewsModel(
              title: article["title"],
              desc: article["description"],
              content: article["content"],
              urlToImage: article["urlToImage"],
              url: article["url"],
              publishedAt: article["publishedAt"],
              sourceModel: SourceModel(id: article["source"]["id"], name:  article["source"]["name"]));
          news.add(newModel);
        }
        return right(news);
      }else{

        return left( ApiFailure(message: jsonDecode(response.body)["message"]));

      }


    } catch (e) {
      debugPrint(e.toString());
      return left(ApiFailure(message: "Oops error occurred!"));
    }
  }
}