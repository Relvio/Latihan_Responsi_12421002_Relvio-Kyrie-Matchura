import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'report_detail_page.dart';

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

class ReportList extends StatefulWidget {
  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  late Future<List<Results>> reports;

  @override
  void initState() {
    super.initState();
    reports = fetchReports();
  }

  Future<List<Results>> fetchReports() async {
    final response = await http.get(Uri.parse(
        'https://api.spaceflightnewsapi.net/v4/reports/?format=json'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => Results.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load reports');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REPORT LIST'),
      ),
      body: FutureBuilder<List<Results>>(
        future: reports,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Results report = snapshot.data![index];
                return Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      report.imageUrl != null
                          ? Image.network(
                              report.imageUrl!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          : Container(),
                      SizedBox(height: 8.0),
                      ListTile(
                        title: Text(report.title!),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ReportDetailPage(reportId: report.id),
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
