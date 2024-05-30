import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../Reports/report_page.dart';
import '../common/drawer.dart';
import '../common/widgets/onpress.dart';
import '../contants/app_color.dart';
import '../contants/utils/utils.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? _imageFile;
  String? _imagePath;

  // final user = FirebaseAuth.instance.currentUser!;
  File? image;
  String _selectedCompany = 'Municipality';
  String _selectedCategory = 'Burst Pipe';
  String currentAddress = 'My Address';
  Position? currentPosition ;
  final faultCategoryController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  final _locationController = TextEditingController();
  final statusController = TextEditingController();
  final locationController = TextEditingController();
  final phoneController = TextEditingController();
  final addressTextController = TextEditingController();
  final recipientTextController = TextEditingController();



  Future<Position>_determinePosition() async{
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      Fluttertoast.showToast(msg: "PLease keep your location on");
    }
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();

      if(permission == LocationPermission.denied){
        Fluttertoast.showToast(msg: "Location Permission is denied");
      }
    }
    if(permission == LocationPermission.deniedForever){
      Fluttertoast.showToast(msg: "Permission is declined Forever ");
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );
    try{
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        currentPosition = position;
        currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    }catch(e){
      print(e);
    }throw("exception");
  }

  final List<String> _stakeholder = [
    'Municipality',
    'ZETDC',


  ];
  final List<String> _categories = [
    'Burst Pipe',
    'Potholes',
    'Electrical Issues',
    'Water leaks',
    'Power outages',
    'Sewage burst'

  ];
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final _picker = ImagePicker();





  final String? path = pickImage(ImageSource.gallery);
  Future<String?> _captureImage(ImageSource source) async{
    try{
      final image = await ImagePicker().pickImage(source: source);
      if(image == null) return null;
      return image.path;
    }on PlatformException catch (e){
      print("Failed to pick Image $e");
    }}



    void signOut(){

      FirebaseAuth.instance.signOut();
    }

    // Future<void> addProduct() async {
    //   try {
    //     FormData formData = FormData();
    //     Map<String, dynamic> productDetails = {
    //       'details': addressTextController.text,
    //       'faultCategories':  faultCategoryController.text,
    //       'status': statusController.text,
    //       'recipient':  recipientTextController.text,
    //       'longitude': _latitudeController.text,
    //       'latitude': _longitudeController.text,
    //       'location': _locationController.text,
    //     };
    //
    //     File compressedFile = await compressFile(File(file!.path));
    //     int fileSizeInBytes = await compressedFile.length();
    //     double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
    //
    //     print('FILE SIZE IS####### ${fileSizeInMB.toStringAsFixed(2)} MB');
    //     formData.files.add(MapEntry(
    //         "productImage",
    //         await MultipartFile.fromFile(
    //           compressedFile!.path,
    //           filename: '${nameInput.value.text}.webp',
    //         )));
    //     productDetails.forEach((key, value) {
    //       formData.fields.add(MapEntry(key, value.toString()));
    //     });
    //     Response productResponse = await Dio(productOptions).post(
    //       'product/create',
    //       data: formData,
    //     );
    //     setState(() {
    //       _isLoading = false;
    //     });
    //
    //     if (productResponse.data['success'] == false) {
    //       await showError(
    //         context,
    //         productResponse.data['message'],
    //       );
    //       return;
    //     }
    //     await showSuccessMessage(
    //         context, "Product uploaded successful!", const MyStore());
    //   } catch (e) {
    //     setState(() {
    //       _isLoading = false;
    //     });
    //     if (e is DioError) {
    //       if (e.type == DioErrorType.connectTimeout) {
    //         await showError(context,
    //             'Connection Failed. Please check you internet connection!!');
    //       } else if (e.type == DioErrorType.receiveTimeout) {
    //         await showError(context,
    //             'Connection Failed. Please check you internet connection!!');
    //       } else if (e.type == DioErrorType.connectTimeout) {
    //         await showError(
    //             context,
    //             'Server issue' + e.response?.data["error"] ??
    //                 'Something went wrong!!');
    //       } else {
    //         await showError(
    //             context,
    //             'Server issue' + e.response?.data["error"] ??
    //                 'Something went wrong!!');
    //       }
    //     } else {
    //       await showError(context, 'Something went wrong!!');
    //     }
    //   }
    // }



    Future<void> _sendReport() async {
      try {
        var request = http.MultipartRequest('POST', Uri.parse('http://localhost:8085/file/create'));
        request.fields.addAll({
          'details': addressTextController.text,
          'faultCategories': faultCategoryController.text,
          'status': statusController.text,
          'recipient': recipientTextController.text,
          'longitude': latitudeController.text,
          'latitude': longitudeController.text,
          'location': _locationController.text,
        });
        request.files.add(await http.MultipartFile.fromPath('image',path!));

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200 || response.statusCode == 201) {
          print(response.statusCode);
          print(response.toString());

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Report successfully Sent'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ),
          );
        } else {
          print(response.statusCode);
          print(response.reasonPhrase);
          print(response.statusCode);
          print(response.toString());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to Send Report: ${response.reasonPhrase}'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }
      } catch (e) {
        print("http error");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Exception occurred: $e'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }





  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldkey,
      drawer: Drawer(
        backgroundColor: AppColor.backgroundColor,
        child: ListView(
          padding:  EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
            Icon(CupertinoIcons.profile_circled,size: 130,color: Colors.grey[700],),
            const SizedBox(height: 15,),
             Padding(
              padding: EdgeInsets.all(12.0),
              // child: Text(
              //    user.email!,
              //   style: TextStyle(
              //       color: AppColor.backgroundColorDark,
              //       fontSize: 20,
              //       fontWeight: FontWeight.w700),
              // ),
            ),
             Padding(
              padding: EdgeInsets.all(12.0),
              child: Text( "Hello, Welcome"
              ,
                style: TextStyle(
                    color: AppColor.backgroundColorDark,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
            // Text(  currentUser.email!,
            //   style: TextStyle(
            //       color: AppColor.white,
            //       fontSize: 20,
            //       fontWeight: FontWeight.w700),
            //   textAlign: TextAlign.center,
            // ),
            const SizedBox(height: 15,),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: () => Navigator.of(context).pop(),
              selectedColor: AppColor.gray60 ,
              selected: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5) ,
              leading:  const Icon( Icons.home,color: AppColor.backgroundColorDark,
                size: 25,) ,
              title:  const Text('H O M E',style: TextStyle(color: AppColor.backgroundColorDark, fontSize: 15,fontWeight: FontWeight.bold)),
            ),

            ListTile(
              onTap:  ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ReportPage())),
              selectedColor: AppColor.gray60 ,
              selected: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5) ,
              leading:  const Icon( Icons.history_rounded,color: AppColor.backgroundColorDark,
                size: 25,) ,
              title:  const Text('R E P O R T    H I S T O R Y',style: TextStyle(color: AppColor.backgroundColorDark, fontSize: 15,fontWeight: FontWeight.bold)),
            ),
            ListTile(
              onTap:(){
                signOut();
              }
              ,
              selectedColor: AppColor.gray60 ,
              selected: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5) ,
              leading:  const Icon( Icons.logout,color: AppColor.backgroundColorDark,
                size: 25,) ,
              title:  Text('L O G O U T',style: TextStyle(color: AppColor.backgroundColorDark, fontSize: 15,fontWeight: FontWeight.bold)),
            ),

          ],
        ),
      ),
      body: SingleChildScrollView(
        child:
        Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 15,left: 15,right: 15,bottom: 10),
              decoration: const BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){  _scaffoldkey.currentState!.openDrawer(); },
                          child: const Icon(
                            CupertinoIcons.list_bullet,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 20,),
                    const Padding(padding: EdgeInsets.only(left: 3,bottom: 15 ),
                      child: Text("Hie, Welcome",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 22,letterSpacing: 1,wordSpacing: 2),),),

                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                 _imageFile != null ?
                  Image.file(
                      File(_imageFile!.path),
                      width: 350,height: 250,fit: BoxFit.cover,
                  )

                  :Icon(CupertinoIcons.photo,size: 200,),
                 //  const Text("Upload Fault Image",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Colors.black),),
                  const SizedBox(height: 14,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: Colors.grey, minimumSize: Size.fromHeight(56),
                        textStyle: TextStyle(fontSize: 20),

                      ),
                      onPressed: ()=> _captureImage,
                      child:  const Row(
                        children: [
                          Icon(CupertinoIcons.photo_camera, size: 28,),
                          SizedBox(width: 14,),
                          Text("Upload Using Camera")
                        ],
                      )),
                  SizedBox(height: 18,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: Colors.grey, minimumSize: Size.fromHeight(56),
                        textStyle: TextStyle(fontSize: 20),

                      ),
                      onPressed:(){
                        _determinePosition();
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> GeoLocationScreen()));
                                  },
                      child:  const Row(
                        children: [
                          Icon(CupertinoIcons.location, size: 28,),
                          SizedBox(width: 14,),
                          Text("Current Location")
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          currentAddress,
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
                        ),
                        currentPosition != null ? CopyOnLongPressWidget(text: ' ${currentPosition!.latitude}',) : const Text('Latitude'),
                        currentPosition != null ? CopyOnLongPressWidget(text: ' ${currentPosition!.longitude}',) : const Text('Latitude'),

                      ],
                    ),
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: latitudeController,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          style: TextStyle(
                              color: Colors.black),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.location,
                              color: Colors.black,),
                            labelText: "Enter Latitude",
                            labelStyle: TextStyle(
                                color: Colors.black),
                            hintStyle: TextStyle(
                                color: Colors.black
                            ),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior
                                .never,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.solid)),
                          ),

                          validator: (val) {
                            if (val!.isNotEmpty) {
                              return null;
                            } else
                              return "Please Enter Latitude";
                          },
                        ),

                      ),
                      const SizedBox(width: 12,),
                      Expanded(
                        child: TextFormField(
                          controller: longitudeController,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          style: TextStyle(
                              color: Colors.black),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.location,
                              color: Colors.black,),
                            labelText: "Enter Longitude",
                            labelStyle: TextStyle(
                                color: Colors.black),
                            hintStyle: TextStyle(
                                color: Colors.black
                            ),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior
                                .never,
                            fillColor: Colors.white.withOpacity(0.3),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.solid)),
                          ),

                          validator: (val) {
                            if (val!.isNotEmpty) {
                              return null;
                            } else
                              return "Please Enter Your Number";
                          },
                        ),

                      ),



                    ],
                  ),
                  const SizedBox(height: 25,),
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: InputDecoration(
                      labelText: 'Select Category',
                      hintStyle: TextStyle(
                        color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20
                      )
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                      });
                    },
                    items: _categories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 12,),
                  DropdownButtonFormField<String>(
                    value: _selectedCompany,
                    decoration: const InputDecoration(
                        labelText: 'Select Recipient',
                        hintStyle: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20
                        )
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCompany = newValue!;
                      });
                    },
                    items: _stakeholder.map((category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                  ),

                  const TextField(
                    decoration: InputDecoration(
                      hintText: "Fault Description"
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: 8,
                  ),
                  SizedBox(height: 24,),
                  Container(
                    padding: EdgeInsets.only(top: 3,left: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: const Border(
                          bottom: BorderSide(color: Colors.transparent),
                          top: BorderSide(color: Colors.transparent),
                          left: BorderSide(color: Colors.transparent),
                          right: BorderSide(color: Colors.transparent),
                        )
                    ),
                    child:
                  // Declare the pickedFile variable

                    MaterialButton(
                      minWidth: double.infinity,
                      height: 40,
                      onPressed: (){
                         _sendReport();

                      },
                      color: AppColor.errorColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Spacer(),
                          const Text("Send Report", style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600
                          ),),
                          Spacer(),
                          Icon(Icons.send,size: 20,color: Colors.white,)
                        ],
                      ),
                    ),
                  )],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
