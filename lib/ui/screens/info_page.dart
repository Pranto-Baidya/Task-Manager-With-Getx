import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled3/ui/screens/new-task-screen.dart';
import 'package:untitled3/ui/utils/app_Colors.dart';
import 'package:untitled3/ui/widgets/TM_Appbar.dart';

class infoPage extends StatelessWidget {
  const infoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEFFF1),
      appBar: TM_AppBar(
       isInfoPageOpen: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text("Task Manager is a versatile task management application designed to help users organize their daily activities, boost productivity, and stay on top of their goals.\n\nKey Features:\n\nTask Creation and Categorization: Quickly add tasks, assign them to custom categories, and set priority levels to ensure important work gets done first.\n\nCreate a Personalized Account: Set up your profile to tailor the app’s features to your unique needs and preferences.\n\nSecured with PIN Verification: Keep your data safe with robust security measures, including PIN verification for added peace of mind.\n\nUpdate Profile Anytime: Easily modify your account details, preferences, and settings whenever needed to keep your app experience up-to-date.",
                style: TextStyle(color: AppColors.themeColor,fontWeight: FontWeight.w500,fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: (){
               Get.back();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Go back',
                    style: TextStyle(color: Color(0xFFFEFFF1), fontSize: 18),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.arrow_circle_left_outlined,
                    color: Color(0xFFFEFFF1),
                  )
                ],
              )
            ),
          )
        ],
      ),
    );
  }
}
