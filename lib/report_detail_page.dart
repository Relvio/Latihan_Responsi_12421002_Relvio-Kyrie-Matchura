import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latihan_responsi_124210012/report_model.dart';

class ReportDetailPage extends StatefulWidget {
  final int? reportId;

  ReportDetailPage({required this.reportId});

  @override
  _ReportDetailPageState createState() => _ReportDetailPageState();
}

class _ReportDetailPageState extends State<ReportDetailPage> {
  late Future<Map<String, dynamic>> reportDetails;

  @override
  void initState() {
    super.initState();
    reportDetails = fetchReportDetails(widget.reportId);
  }

  Future<Map<String, dynamic>> fetchReportDetails(int? reportId) async {
    final response = await http.get(
        Uri.parse('https://api.spaceflightnewsapi.net/v4/reports/$reportId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load report details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REPORT DETAIL'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: reportDetails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Extract details from the snapshot.data
            Results report = Results.fromJson(snapshot.data!);

            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Title: ${report.title ?? 'N/A'}'),
                    if (report.imageUrl != null)
                      Image.network(
                        report.imageUrl!,
                        height: 500, // Set the desired height
                        width: 500, // Set the desired width
                      ),
                    Text(' ${report.url ?? 'N/A'}'),
                    Text(
                      '${report.newsSite ?? 'N/A'}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(' ${report.summary ?? 'N/A'}'),
                    Text('Published At: ${report.publishedAt ?? 'N/A'}'),
                    Text('Updated At: ${report.updatedAt ?? 'N/A'}'),
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
