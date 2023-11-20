import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latihan_responsi_124210012/blog_model.dart';

class BlogDetailPage extends StatefulWidget {
  final int? blogId;

  BlogDetailPage({required this.blogId});

  @override
  _BlogDetailPageState createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  late Future<Map<String, dynamic>> BlogDetails;

  @override
  void initState() {
    super.initState();
    BlogDetails = fetchBlogsDetails(widget.blogId);
  }

  Future<Map<String, dynamic>> fetchBlogsDetails(int? blogId) async {
    final response = await http
        .get(Uri.parse('https://api.spaceflightnewsapi.net/v4/blogs/$blogId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load blog details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLOG DETAIL'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: BlogDetails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Extract details from the snapshot.data
            Results blog = Results.fromJson(snapshot.data!);

            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Title: ${blog.title ?? 'N/A'}'),
                    if (blog.imageUrl != null)
                      Image.network(
                        blog.imageUrl!,
                        height: 500, // Set the desired height
                        width: 500, // Set the desired width
                      ),
                    Text(' ${blog.url ?? 'N/A'}'),
                    Text(
                      '${blog.newsSite ?? 'N/A'}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(' ${blog.summary ?? 'N/A'}'),
                    Text('Published At: ${blog.publishedAt ?? 'N/A'}'),
                    Text('Updated At: ${blog.updatedAt ?? 'N/A'}'),
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
