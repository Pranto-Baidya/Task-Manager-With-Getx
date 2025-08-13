import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class spinKit{

  static  Widget splashLoader(){
    return SpinKitDualRing(
      lineWidth: 3,
      color: Color(0xFFFEFFF1),
      size: 40,
    );
  }
  static  Widget mainLoader(){
    return SpinKitDualRing(
      lineWidth: 3,
      color: Color(0xFF003366),
      size: 40,
    );
  }
  static Widget normalLoader(){
     return  SpinKitDualRing(
       lineWidth: 3,
      color: Color(0xFFFEFFF1),
      size: 30,
    );
  }

  static Widget taskLoader(){
    return  SpinKitDualRing(
      lineWidth: 3,
      color: Color(0xFF003366),
      size: 25,
    );
  }
}