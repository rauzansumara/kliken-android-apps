import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:kliken/model/library.dart';
import 'dart:convert';

String _baseURL = "https://kliken2.herokuapp.com/";
String _news = "news/";
String _suggestion = "suggestion";
String _headerKey = "x-api-key";
String _headerValue = "XYKzQLGstEUazFbZM6jtZxvUu7nY4nVRzDsuLzcFKp7D0EyKdA";
String _postHeaderKey = "Authorization";
String _postHeaderValue =
    "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1NDU5Njc3MzYsIm5iZiI6MTU0NTk2NzczNiwianRpIjoiZjcyZmJkZGYtODgyOS00NjAwLWJmODAtMmE3NTI1ZjQ3NzcxIiwiZXhwIjoxNTQ5NTY3NzM2LCJpZGVudGl0eSI6ImJhZ2FzIiwiZnJlc2giOmZhbHNlLCJ0eXBlIjoiYWNjZXNzIn0.llYbW2bszhgNOQlMXZl5WE9dhBYk78N3mKqnDgArq2A";

///This class used to return Json data from back-end API
class Api {
  /// To return all value from Json
  Future<Response> getData(String page) async {
//    print("Get data $page");
    final url = "$_baseURL$_news$page";

    //TODO: Add error handling here
    final parseData = await http.get(url, headers: {_headerKey: _headerValue});
//    print("Parse data $page");
    final responseJson = json.decode(parseData.body);
    final newsResponse = Response.fromJson(responseJson);
//    print(newsResponse.status);
    return newsResponse;
  }

  /// To return just article value from json
  Future<List<News>> getNews(String page) async {
    final data = await getData(page);
//    print("raw news: ${data.data.news}");
    List<News> newsList = data.data.news;
    //print("news: $newsList");
    return newsList;
  }

  Future<dynamic> postData(user, title, link, sugesstedAs) async {
    String _urlSugesstion = "$_baseURL$_suggestion";
    var _body = {
      'username': user,
      'news_title': title,
      'news_link': link,
      'value': sugesstedAs
    };
    var _header = {_postHeaderKey: _postHeaderValue};
    var response =
    await http.post(_urlSugesstion, body: _body, headers: _header);
    print('Response status: ${response.statusCode}');
    return response.statusCode;
  }
}
