
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../contants/app_color.dart';





class SocialButtons extends StatefulWidget {
  const SocialButtons({
    super.key,
  });

  @override
  State<SocialButtons> createState() => _SocialButtonsState();
}

class _SocialButtonsState extends State<SocialButtons> {
  // final FirebaseAuth auth = FirebaseAuth.instance;
  //
  // User? _user;

  // @override
  // void initState(){
  //   super.initState();
  //   auth.authStateChanges().listen((event) {
  //     setState(() {
  //       _user= event;
  //     });
  //   });
  // }
  // void handleGoogleSignIn(){
  //   try{
  //     GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
  //     auth.signInWithProvider(googleAuthProvider);
  //
  //   }catch(error){
  //     print(error);
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color:AppColor.gray20),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
              onPressed: (){},
              // handleGoogleSignIn,
              icon: const Image(
                  width: 24, height: 24,
                  image: AssetImage("assets/google_icon.png"))),
        ),


      ],
    );
  }
}