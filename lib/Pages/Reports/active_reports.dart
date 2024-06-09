import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../../Models/report_model.dart';

class ActiveReportsPage extends StatefulWidget {
  const ActiveReportsPage({super.key});

  @override
  State<ActiveReportsPage> createState() => _ActiveReportsPageState();
}

class _ActiveReportsPageState extends State<ActiveReportsPage> {
  List<FaultModel> _reports = [];

  @override
  void initState() {
    super.initState();
    _fetchReportData();
  }

  Future<void> _fetchReportData() async {
    final response = await http.get(Uri.parse('https://api.example.com/reports'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _reports = (data as List)
            .map((reportData) => FaultModel.fromJson(reportData))
            .toList();
      });
    } else {
      // Handle error
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, color: Colors.black,)),
        centerTitle: true,
        title:  Text("Active  Reports",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22,letterSpacing: 1,wordSpacing: 2),),

      ),
      body: ListView.builder(
        itemCount: _reports.length,
        itemBuilder: (context, index) {
          final report = _reports[index];
          return _buildReportTile(report);
        },
      ),
    );
  }

  Widget _buildReportTile(FaultModel report) {
    Color statusColor;
    switch (report.status) {
      case 'RECEIVED':
        statusColor = Colors.lightBlue.withOpacity(0.8);
        break;
      case 'UNDER_INVESTIGATION':
      case 'RESOLVED':
        statusColor = Colors.green.withOpacity(0.8);
        break;
      default:
        statusColor = Colors.grey.withOpacity(0.8);
    }

    return Card(
      color: statusColor,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Report ID: ${report.id}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Status: ${report.status}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Description: ${report.details}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
