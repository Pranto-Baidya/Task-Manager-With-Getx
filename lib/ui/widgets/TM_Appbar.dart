import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled3/data/auth_controllers/authentication.dart';
import 'package:untitled3/data/screen_Controllers/profile_screen_controller.dart';
import 'package:untitled3/ui/screens/add-new-task-screen.dart';
import 'package:untitled3/ui/screens/info_page.dart';
import 'package:untitled3/ui/screens/new-task-screen.dart';

import 'package:untitled3/ui/screens/profile_screen.dart';
import 'package:untitled3/ui/screens/sign-in_screen.dart';
import 'package:untitled3/ui/utils/app_Colors.dart';
import 'package:untitled3/ui/utils/spinkit.dart';
import 'package:untitled3/ui/utils/toastMessage.dart';

class TM_AppBar extends StatefulWidget implements PreferredSizeWidget {



  const TM_AppBar({
    super.key,
    this.isProfileScreenOpen = false,
    this.isInfoPageOpen,


  });

  final bool isProfileScreenOpen;
  final bool? isInfoPageOpen;

  @override
  _TM_AppBarState createState() => _TM_AppBarState();

  @override
  Size get preferredSize => Size.fromHeight(70);
}

class _TM_AppBarState extends State<TM_AppBar> {

  final profileController controller = Get.find<profileController>();

  @override
  void initState() {
    super.initState();
  }

  bool _isLoggingOut = false;

  alert(context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Color(0xFFFEFFF1),
            title: Text('Wait!',style: TextStyle(color: AppColors.themeColor,fontSize: 25,fontWeight: FontWeight.w600),),
            content: Text('Are you sure you want to log out?',style: TextStyle(color: Color(0xFF003366),fontSize: 16,fontWeight: FontWeight.w400),),
            actions: [
               TextButton(
                  onPressed: ()async{
                    setState(() {
                      _isLoggingOut = true;
                    });

                    await Future.delayed(Duration(seconds: 2));
                    await authentication.clearUserData();
                    Get.offAll(signInScreen(),transition: Transition.leftToRightWithFade);

                    SuccessToast('Successfully logged out');

                    setState(() {
                      _isLoggingOut = false;
                    });
                  },
                  child:  Text(
                    'Yes',
                    style: TextStyle(
                      color: Color(0xFF003366),
                    ),
                  )
              ),
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text('No',style: TextStyle(
                    color: Color(0xFF003366),
                  ),)
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isProfileScreenOpen) {
          return;
        }
        Get.to(()=> profileScreen(),transition: Transition.leftToRightWithFade);
      },
      child: AppBar(
        systemOverlayStyle:  SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.black,
          statusBarColor: Colors.transparent, // Set to transparent for full-screen effect
          statusBarIconBrightness: Brightness.light,
        ),
        iconTheme: IconThemeData(color: Color(0xFFFEFFF1)),
        toolbarHeight: 65,
        backgroundColor: Color(0xFF003366),
        title: Visibility(
          visible: widget.isInfoPageOpen!=true,
          replacement: Text('About Task Manager',style: TextStyle(color: Color(0xFFFEFFF1),fontSize: 20),),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFFFEFFF1),
                radius: 20,
                child: Icon(Icons.person,color: AppColors.themeColor,),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authentication.userData?.fullName ?? 'Guest',
                      style: TextStyle(
                        color:  Color(0xFFFEFFF1),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      authentication.userData?.email ?? 'No email',
                      style: TextStyle(
                        color: Color(0xFFFEFFF1),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: (){
                 Get.to(infoPage(),transition: Transition.leftToRightWithFade);
                },
                icon: Icon(Icons.info_outline, color: Color(0xFFFEFFF1),),
              ),
              IconButton(
                onPressed: () async {
                  alert(context);
                },
                icon: _isLoggingOut
                    ? spinKit.normalLoader()
                    : Icon(Icons.logout, color: Color(0xFFFEFFF1),),
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF003366), Color(0xFF003366)]),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 1),
                blurRadius: 2,
                spreadRadius: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
