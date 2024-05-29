import 'package:flutter/cupertino.dart';

import '../../contants/app_color.dart';



class LogInHeader extends StatelessWidget {
  const LogInHeader({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image(
            height: 280,
            image: AssetImage("assets/images/header.png"),
          ),
        ),
        SizedBox(height: 20,),
        Text("Hello ,Welcome back",
          style:
          TextStyle(
              color: AppColor.secondary,
              fontWeight: FontWeight.bold,
              fontSize: 30
          ),),
        SizedBox(height: 10,),
      ],
    );
  }
}