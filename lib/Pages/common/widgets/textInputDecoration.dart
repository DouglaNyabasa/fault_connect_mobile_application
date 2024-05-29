
import 'package:flutter/material.dart';

import '../../contants/app_color.dart';



final textInputDecoration = InputDecoration(
  labelStyle: TextStyle(
    color: Colors.white, fontWeight: FontWeight.w300
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.blue,width: 2,
    ),
  ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: AppColor.primarySoft,width: 2
      ),),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
        color:AppColor.secondary0,width: 2
    ),
  ),

  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: const BorderSide(width: 0, style: BorderStyle.none)),

);


void nextScreen(context, page){
  Navigator.push(context, MaterialPageRoute(builder: (context)=> page));
}

void nextScreenReplace(context, page){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> page));
}