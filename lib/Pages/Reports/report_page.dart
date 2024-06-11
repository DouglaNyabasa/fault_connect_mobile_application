import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../Models/report_model.dart';


class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<FaultModel> reports = [];
  bool isLoading = false;
  final _imagePicker = ImagePicker();
  File? _selectedImage;

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
          reports = reportData.map((json) => FaultModel.fromJson(json)).toList();
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
  Future<void> _getImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
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
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: reports.length,
        itemBuilder: (context, index) {
          final report = reports[index];
          return Card(
            elevation: 4.0,
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (report.imageUrl != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            report.imageUrl!,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      Text(
                        report.faultCategories ?? '',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text('Details: ${report.details ?? ''}'),
                      SizedBox(height: 8.0),
                      Text('Date: ${report.dateTime ?? ''}'),
                      SizedBox(height: 8.0),
                      Text('Status: ${report.status ?? ''}'),
                      SizedBox(height: 8.0),
                      Text('Longitude: ${report.longitude ?? ''}'),
                      SizedBox(height: 8.0),
                      Text('Latitude: ${report.latitude ?? ''}'),
                      SizedBox(height: 8.0),
                      Text('Recipient: ${report.recipient ?? ''}'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}