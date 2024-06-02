import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import '../../Models/report_model.dart';
import '../contants/app_color.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<ReportModel> reports = [];

  @override
  void initState() {
    super.initState();
    getAllFaults();
  }
  static Future<List<ReportModel>> getAllFaults() async {
    final request = http.Request('GET', Uri.parse('http://localhost:8085/faults/getAll'));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final List<dynamic> faultsJson = jsonDecode(responseBody);

      return faultsJson.map((json) => ReportModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch faults: ${response.reasonPhrase}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, color: Colors.black,)),
        centerTitle: true,
        title:  Text("All Reports",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22,letterSpacing: 1,wordSpacing: 2),),

      ),
      body: reports.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
        itemCount: reports.length,
        itemBuilder: (context, index) {
          final report = reports[index];
          return ListTile(
            title: Text(report.details ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                          Text('Fault Categories: ${report.faultCategories ?? ''}'),
                          Text('location: ${report.latitudeController ?? ''}'),
                          Text('location: ${report.longitudeController ?? ''}'),
                          Text('recipient: ${report.recipient ?? ''}'),
                          Text('Status: ${report.status ?? ''}'),
                          Text('Date/Time: ${report.dateTime ?? ''}'),
                          Text('Status: ${report.status ?? ''}'),
              ],
            ),
            leading: report.image != null
                ? Image.network(report.image!)
                : SizedBox(),
            onTap: () {
              // Navigate to the report details screen or perform any other action
            },
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}
