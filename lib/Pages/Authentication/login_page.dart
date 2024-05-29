
import 'package:fault_connect/Pages/Authentication/register_page.dart';
import 'package:fault_connect/Pages/HomePage/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:iconsax/iconsax.dart';

import '../common/widgets/header.dart';
import '../common/widgets/textInputDecoration.dart';
import '../contants/app_color.dart';
import '../contants/sizes.dart';
import '../contants/spacing_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _key = GlobalKey <FormState>();
  var _isObscured;
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  @override
  void initState(){
    super.initState();
    _isObscured = true;
  }

  void signIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );

      if (context.mounted) {
        // Navigate to the home screen after successful sign-in
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()), // Replace 'HomeScreen()' with your actual home screen widget
              (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      Get.snackbar(
        "Required",
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.secondary50,
        colorText: AppColor.backgroundColorDark,
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.black, size: 30),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(

          child: Padding(
            padding:TSpacingStyles.paddingWIthAppBarHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                LogInHeader(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Form
                    (
                      key: _key,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailTextController,
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.black,
                            style: TextStyle(
                                color: Colors.black),
                            decoration:  InputDecoration(
                              prefixIcon: Icon( Icons.email_outlined, color: Colors.black,) ,

                              labelText: "Email",
                              labelStyle: TextStyle(color: Colors.black),
                              hintStyle: TextStyle(
                                  color: Colors.black
                              ),
                              filled: true,
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: const BorderSide(width: 0, style: BorderStyle.solid)),
                            ) ,

                            validator: (val){
                              return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!)? null : "Please Enter a Valid Email";
                            },
                          ),
                          const SizedBox(height: 20,),
                          TextFormField(
                            controller: passwordTextController,
                            obscureText: _isObscured,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.black,
                            style: TextStyle(
                                color: Colors.black),
                            decoration:  InputDecoration(
                              prefixIcon: Icon( Iconsax.password_check, color: Colors.black,) ,
                              suffixIcon: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _isObscured =! _isObscured;
                                    });
                                  }, icon: _isObscured ? Icon(Icons.remove_red_eye_sharp, color: Colors.black,) :Icon(Iconsax.eye_slash, color: Colors.black,)
                              ),

                              labelText: "Password",
                              labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
                              hintStyle: TextStyle(
                                  color: Colors.black
                              ),
                              filled: true,
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: const BorderSide(width: 0, style: BorderStyle.solid)),
                            ) ,

                            onChanged: (value){
                              setState(() {
                                _key.currentState!.validate();
                              });
                            },
                          ),


                          // reusablePasswordTextField('Password', Iconsax.password_check, true, passwordTextController, Iconsax.eye_slash),
                          const SizedBox(height: 20,),

                          const SizedBox(height: SizeConfig.spacingBetween,),
                          Container(
                            padding: EdgeInsets.only(top: 3,left: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: const Border(
                                  bottom: BorderSide(color: Colors.white),
                                  top: BorderSide(color: Colors.white),
                                  left: BorderSide(color: Colors.white),
                                  right: BorderSide(color: Colors.white),
                                )
                            ),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 40,
                              onPressed: (){
                                signIn();


                              },

                              color: AppColor.secondary2,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              child: const Text("Sign in", style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600
                              ),),
                            ),
                          ),
                          const SizedBox(height: 16,),
                          Text.rich(
                            TextSpan(
                                text:   "Don\'t have an Account ?   ",
                                style:
                                TextStyle(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold
                                ),
                                children: <TextSpan>[

                                  TextSpan(
                                      text: "Register here !",
                                      style:
                                      TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline
                                      ),
                                      recognizer: TapGestureRecognizer()..onTap=(){
                                        nextScreen(context, const RegisterPage());
                                      }
                                  )
                                ]
                            ),
                          ),
                        ],
                      )
                  ),
                ),

              ],
            ),),
        )
    );
  }
}
