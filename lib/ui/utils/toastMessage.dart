import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled3/main.dart';
import 'package:hugeicons/hugeicons.dart';

void SuccessToast(msg){
  Get.snackbar(
      'Success',
       msg,
       snackPosition: SnackPosition.BOTTOM,
       backgroundColor: Colors.green,
       colorText: Colors.white,
       margin: EdgeInsets.all(20),
       borderRadius: 8,
       messageText: Text(msg, style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),),
       titleText: Text('Success',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
       isDismissible: true,
       icon: HugeIcon(
          icon: HugeIcons.strokeRoundedSmile,
          color: Colors.white
      ),
      duration: Duration(seconds: 2)
  );


   /* Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16
    ); */
  }
  void ErrorToast(msg){

    Get.snackbar(
        'Error',
        msg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.all(20),
        borderRadius: 8,
        messageText: Text(msg, style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),),
        titleText: Text('Error',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
        isDismissible: true,
        icon: HugeIcon(
            icon: HugeIcons.strokeRoundedSad01,
            color: Colors.white
        ),
      duration: Duration(seconds: 2)
    );
    /*Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16
    );*/
  }
