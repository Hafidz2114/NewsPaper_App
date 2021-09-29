// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:apps_newspaper/constants/strings.dart';
import 'package:apps_newspaper/models/newsInfo.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class API_Manager {
  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      var response = await client.get(Uri.parse(Strings.newsUrl));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = NewsModel.fromJson(jsonMap);
      }

    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }
}
