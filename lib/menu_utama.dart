import 'package:flutter/material.dart';
import 'package:latihan_responsi_124210012/article_list.dart';
import 'package:latihan_responsi_124210012/blog_list.dart';
import 'package:latihan_responsi_124210012/report_list.dart';

class MenuItem extends StatelessWidget {
  final String imagePath;
  final String label;
  final String description;
  final VoidCallback onTap;

  const MenuItem({
    required this.imagePath,
    required this.label,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
                imagePath,
                height: 300.0,
                width: 300.0,
              ),
              SizedBox(height: 8.0),
              Text(
                label,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MENU UTAMA'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MenuItem(
                imagePath: 'assets/news.png',
                label: 'News',
                description:
                    'Get an overview of the latest Spaceflight news, from various sources! Easily link your users to the right websites',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ArticleList()),
                  );
                },
              ),
              MenuItem(
                imagePath: 'assets/blog.png',
                label: 'Blog',
                description:
                    'Blogs often provide a more detailed overview of launches and missions. A must-have for the serious spaceflight enthusiast',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BlogList()),
                  );
                },
              ),
              MenuItem(
                imagePath: 'assets/report.png',
                label: 'Reports',
                description:
                    'Space stations and other missions often publish their data. With SNAPI, you can include it in your app as well!',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReportList()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
