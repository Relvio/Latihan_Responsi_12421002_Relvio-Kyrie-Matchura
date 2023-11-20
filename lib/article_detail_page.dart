import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latihan_responsi_124210012/article_model.dart';

class ArticleDetailPage extends StatefulWidget {
  final int? articleId;

  ArticleDetailPage({required this.articleId});

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  late Future<Map<String, dynamic>> articleDetails;

  @override
  void initState() {
    super.initState();
    articleDetails = fetchArticlesDetails(widget.articleId);
  }

  Future<Map<String, dynamic>> fetchArticlesDetails(int? articleId) async {
    final response = await http.get(
        Uri.parse('https://api.spaceflightnewsapi.net/v4/articles/$articleId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load Article details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEWS DETAIL'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: articleDetails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Extract details from the snapshot.data
            Results article = Results.fromJson(snapshot.data!);

            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Title: ${article.title ?? 'N/A'}'),
                    if (article.imageUrl != null)
                      Image.network(
                        article.imageUrl!,
                        height: 500, // Set the desired height
                        width: 500, // Set the desired width
                      ),
                    Text(' ${article.url ?? 'N/A'}'),
                    Text(
                      '${article.newsSite ?? 'N/A'}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(' ${article.summary ?? 'N/A'}'),
                    Text('Published At: ${article.publishedAt ?? 'N/A'}'),
                    Text('Updated At: ${article.updatedAt ?? 'N/A'}'),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
