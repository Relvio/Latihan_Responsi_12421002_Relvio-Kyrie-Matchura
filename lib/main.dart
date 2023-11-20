import 'package:flutter/material.dart';
import 'package:latihan_responsi_124210012/menu_utama.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MainMenu());
  }
}









/*import 'package:flutter/material.dart';
import 'package:latihan_responsi_124210012/article_list.dart';
import 'package:latihan_responsi_124210012/blog_list.dart';
import 'package:latihan_responsi_124210012/report_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main Menu',
      home: MainMenu(),
      routes: {
        '/articleList': (context) => ArticleList(),
        '/blogList': (context) => BlogList(),
        '/reportList': (context) => ReportList(),
      },
    );
  }
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MenuItem(
            imageUrl:
                'https://www.spaceflightnewsapi.net/img/features/News.svg',
            label: 'News',
            onTap: () {
              Navigator.pushNamed(
                  context, '/articleList'); // Ganti dengan '/articleList'
            },
          ),
          MenuItem(
            imageUrl:
                'https://www.spaceflightnewsapi.net/img/features/Blogs.svg',
            label: 'Blog',
            onTap: () {
              Navigator.pushNamed(
                  context, '/blogList'); // Ganti dengan '/blogList'
            },
          ),
          MenuItem(
            imageUrl:
                'https://www.spaceflightnewsapi.net/img/features/Reports.svg',
            label: 'Reports',
            onTap: () {
              Navigator.pushNamed(
                  context, '/reportList'); // Ganti dengan '/reportList'
            },
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String imageUrl;
  final String label;
  final VoidCallback onTap;

  const MenuItem({
    required this.imageUrl,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              imageUrl,
              height: 200.0,
              width: 200.0,
            ),
            SizedBox(height: 8.0),
            Text(
              label,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}*/
