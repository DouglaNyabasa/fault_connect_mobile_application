
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../contants/app_color.dart';







class FormDivider extends StatelessWidget {
  const FormDivider({
    super.key, required this.dividerText,

  });


  final String dividerText;

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: Divider(color: AppColor.gray70,thickness: 0.5,indent: 60,endIndent: 5,)),
        Text(dividerText,style: TextStyle(color: AppColor.gray50,)),
        Flexible(child: Divider(color: AppColor.gray70,thickness: 0.5,indent: 5,endIndent: 60,)),

      ],
    );
  }
}