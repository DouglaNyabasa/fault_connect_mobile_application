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
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchReports();
  }

  // CHANGE THE Uri TO THE IP ADDRESS OF YOUR COMPUTER
  // CHANGE TO YOUR IP ADDRESS HERE >> 'http://192.168.43.32:8085/faults/getAllFaults' ,REPLACE '192.168.43.32' WITH YOUR IP ADDRESS
  Future<void> fetchReports() async {
    setState(() {
      isLoading = true;
    });
    try {
      // 'http://10.160.1.201:8085/file/create'
      final response = await http.get(Uri.parse('http://192.168.43.32:8085/faults/getAllFaults'));
      if (response.statusCode == 200) {
        final List<dynamic> reportData = jsonDecode(response.body);
        print(response.statusCode);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Reports Fetched successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
        setState(() {
          _reports = reportData.map((json) => FaultModel.fromJson(json)).toList();
        });
      } else {
        print(response.statusCode);
        print(response.reasonPhrase);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to Fetch report'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print('Error fetching reports: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
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
