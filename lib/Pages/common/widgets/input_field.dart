import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../contants/app_color.dart';





class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget?  widget;
  const MyInputField({super.key, required this.title, required this.hint,  this.controller, this.widget});

  @override
  Widget build(BuildContext context) {
    return
      Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(title,
         style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: AppColor.gray10,)),
          Container(
            height: 52,
            margin: EdgeInsets.only(top: 8.0),
            padding: EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              border :Border.all(
                color: AppColor.gray10,
                width: 1.0
              ),
              borderRadius: BorderRadius.circular(12)
            ),
            child: Row(
              children: [
                Expanded(child:
                TextFormField(
                  readOnly: widget == null? false:true,
                  autofocus: false,
                  cursorColor: Colors.black12,
                  controller: controller,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    color: AppColor.gray10,
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    color: AppColor.gray10,
                  ),
                    enabledBorder: UnderlineInputBorder(
                     borderSide: BorderSide(
                       color: Colors.transparent,
                        width: 0
                  ),

            ),
                  ),
                )),
                widget == null ? Container():Container(child: widget,)
              ],
            ),


          )

        ],
      ),
    );
  }
}
