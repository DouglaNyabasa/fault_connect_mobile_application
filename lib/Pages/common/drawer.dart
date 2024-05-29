import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../contants/app_color.dart';



class DrawerView extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onProfileTap;
  final void Function()? logOut;
  final void Function()? notification;
  DrawerView({super.key, this.onTap, this.onProfileTap, this.logOut, this.notification});

  // void signOut(){
  //   FirebaseAuth.instance.signOut();
  // }

  @override
  Widget build(BuildContext context) {
    final res_width = MediaQuery.of(context).size.width;
    final res_height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      child: Drawer(
        backgroundColor: AppColor.backgroundColorDark,
        child: ListView(
          padding: EdgeInsets.only(left: 25,right:10 ),
          children: [
            SizedBox(height: res_height * 0.075,),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.gray60,
                    borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                child: GestureDetector(
                  onTap: (){Navigator.pop(context);},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.close,color: Colors.white,size: 25,),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: res_height*0.0175,
            ),
            Text(
              "Douglas Nyabasa",
              style: TextStyle(
                  color: AppColor.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 4,),
            Text(
              "douglasnyabasa400@gmail.com",
              style: TextStyle(
                  color: AppColor.gray30,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: res_height*0.04,),
            const DrawerItems(icon: Icons.home ,text: 'H O M E',),
            const DrawerItems(icon: Icons.notifications_active_outlined ,text: 'N O T I F I C A T I O N S',),
            const DrawerItems(icon: Icons.history ,text: 'R E P O R T   H I S T O R Y',),
            const DrawerItems(icon: Icons.logout ,text: 'L O G O U T',   ),

          ],
        ),
      ),
    );

  }
}

class DrawerItems extends StatelessWidget {
  final void Function()? onTap;
  final text;
  final icon;
  const DrawerItems({super.key, this.text, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: AppColor.background,
        size: 25,
      ) ,
      onTap: (){
        Navigator.pop(context);
      },
      title: Text(text,style: TextStyle(color: AppColor.gray10, fontSize: 15,fontWeight: FontWeight.bold)),

    );
  }
}

