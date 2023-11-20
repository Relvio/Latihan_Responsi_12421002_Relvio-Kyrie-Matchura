import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latihan_responsi_124210012/article_model.dart';

class ApiService {
  static const String newsApiUrl =
      'https://api.spaceflightnewsapi.net/v4/articles/?format=json';
  static const String blogsApiUrl =
      'https://api.spaceflightnewsapi.net/v4/blogs/?format=json';
  static const String reportsApiUrl =
      'https://api.spaceflightnewsapi.net/v4/reports/?format=json';

  static Future<List<Results>> fetchArticles() async {
    final response = await http.get(Uri.parse(newsApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => Results.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  static Future<List<Results>> fetchBlogs() async {
    final response = await http.get(Uri.parse(blogsApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => Results.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load blogs');
    }
  }

  static Future<List<Results>> fetchReports() async {
    final response = await http.get(Uri.parse(reportsApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => Results.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load reports');
    }
  }
}
