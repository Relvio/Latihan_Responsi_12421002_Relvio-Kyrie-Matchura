import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latihan_responsi_124210012/blog_detail_page.dart';
import 'dart:convert';

class Results {
  final int? id;
  final String? title;
  final String? imageUrl;

  Results({this.id, this.title, this.imageUrl});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image_url'],
    );
  }
}

class BlogList extends StatefulWidget {
  @override
  _BlogListState createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  late Future<List<Results>> blogs;

  @override
  void initState() {
    super.initState();
    blogs = fetchBlogs();
  }

  Future<List<Results>> fetchBlogs() async {
    final response = await http.get(
        Uri.parse('https://api.spaceflightnewsapi.net/v4/blogs/?format=json'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => Results.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load blogs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLOG LIST'),
      ),
      body: FutureBuilder<List<Results>>(
        future: blogs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Results blogs = snapshot.data![index];
                return Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      blogs.imageUrl != null
                          ? Image.network(
                              blogs.imageUrl!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          : Container(),
                      SizedBox(height: 8.0),
                      ListTile(
                        title: Text(blogs.title!),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BlogDetailPage(blogId: blogs.id),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
