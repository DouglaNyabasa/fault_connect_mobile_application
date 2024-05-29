import 'package:fault_connect/Pages/HomePage/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:iconsax/iconsax.dart';

import '../contants/app_color.dart';
import '../contants/sizes.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _key = GlobalKey <FormState>();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmpasswordTextController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressTextController = TextEditingController();
  var _isObscured;
  @override
  void initState(){
    super.initState();
    _isObscured = true;
  }

  void displayMessage(String message){
    showDialog(context: context,
        builder: (context)=> AlertDialog(
          title: Text(message),
        ));
  }
  void signUp() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (passwordTextController.text != confirmpasswordTextController.text) {
      Navigator.pop(context);
      displayMessage("Passwords don't match");
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );

      if (context.mounted) {
        // Navigate to the homepage after successful authentication
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()), // Replace 'HomePage()' with your actual homepage widget
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
  bool confirmpassword(){
    if(passwordTextController.text.trim() == confirmpasswordTextController.text.trim()){
      return true;
    }else{
      return false;
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, color: Colors.black,)),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(SizeConfig.defaultSpacing1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(" Let\'s Create An Account !!", style:
            TextStyle(
                color: AppColor.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 30
            ),
            ),

            const SizedBox(height: 40,),
            Form(
                key: _key,

                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: fullNameController,
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.black,
                            style: TextStyle(
                                color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_2_outlined,
                                color: Colors.black,),
                              labelText: "Full Name",
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
                                return "Please Enter Full Name";
                            },
                          ),

                        ),
                        const SizedBox(width: 12,),
                        Expanded(
                          child: TextFormField(
                            controller: phoneController,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            style: TextStyle(
                                color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone,
                                color: Colors.black,),
                              labelText: "Phone Number",
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
                    TextFormField(
                      controller: emailTextController,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.black,
                      style: TextStyle(

                          color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email_outlined, color: Colors.black,),

                        labelText: "Email",
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
                        return RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val!)
                            ? null
                            : "Please Enter a Valid Email";
                      },
                    ),
                    const SizedBox(height: 25,),
                    TextFormField(
                      controller: addressTextController,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.black,
                      style: TextStyle(

                          color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Iconsax.location, color: Colors.black,),

                        labelText: "Address",
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
                          return "Please Enter Your Address";
                      },
                    ),

                    const SizedBox(height: 25,),
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
                    const SizedBox(height: 25,),
                    TextFormField(
                      controller: confirmpasswordTextController,
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

                        labelText: "Confirm Password",
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

                    const SizedBox(height: 25,),
                    Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
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
                        onPressed: () {
                          signUp();
                        },
                        color: AppColor.secondary2,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: const Text("Create Account", style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                        ),),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an Account ?",
                          style:
                          TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(width: 5,),

                        GestureDetector(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginPage())),
                          child: Text("Sign-In now !",
                            style:
                            TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold
                            ),),
                        )
                      ],
                    ),

                  ],
                )
            ),
          ],
        ),
      ),

    );
  }
}
