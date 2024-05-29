import 'package:flutter/material.dart';

import '../../contants/app_color.dart';




void showSnackBar(context,message, color ){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message,style: const TextStyle(color :AppColor.backgroundColorDark,fontSize: 14 )),
        backgroundColor:  color,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
            label: "OK",
            onPressed: (){},
        textColor: Colors.black,) ,



      ));
}
