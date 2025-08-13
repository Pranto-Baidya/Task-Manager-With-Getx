import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled3/data/auth_controllers/authentication.dart';
import 'package:untitled3/ui/screens/main_bottom_nav_screen.dart';
import 'package:untitled3/ui/screens/sign-in_screen.dart';
import 'package:untitled3/ui/utils/asset_Path.dart';
import 'package:untitled3/ui/utils/spinkit.dart';
import 'package:untitled3/ui/widgets/screen_background.dart';


class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState(){
    super.initState();
    moveToNextScreen();
  }

  Future<void> moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    await authentication.getAccessToken();

    if (authentication.isLoggedIn()) {
      await authentication.getUserData();

      Get.off(mainBottomNavScreen(),transition: Transition.leftToRightWithFade);

    } else {
      Get.off(signInScreen(),transition: Transition.leftToRightWithFade);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF003366),
        body: Center(
          child: _buildColumn(),
        ));
  }

  Widget _buildColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(assetPaths.logoSVG),

        spinKit.splashLoader()
      ],
    );
  }
}
