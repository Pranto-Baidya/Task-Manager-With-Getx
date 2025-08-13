

import 'package:get/get.dart';
import 'package:untitled3/data/screen_Controllers/add_new_task_controller.dart';
import 'package:untitled3/data/screen_Controllers/forgot_pass_controller.dart';
import 'package:untitled3/data/screen_Controllers/inProgressTask_controller.dart';
import 'package:untitled3/data/screen_Controllers/newTask_controller.dart';
import 'package:untitled3/data/screen_Controllers/pin_verify_controller.dart';
import 'package:untitled3/data/screen_Controllers/profile_screen_controller.dart';
import 'package:untitled3/data/screen_Controllers/set_pass_controller.dart';
import 'package:untitled3/data/screen_Controllers/sign_in_controller.dart';
import 'package:untitled3/data/screen_Controllers/taskCard_controller.dart';
import 'data/screen_Controllers/cancelledTask_controller.dart';
import 'data/screen_Controllers/completedTask_controller.dart';
import 'data/screen_Controllers/sign_up_controller.dart';

class controllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(signInController());
    Get.put(signUpController());
    Get.put(newTaskController());
    Get.put(completedTaskController());
    Get.put(inProgressTaskController());
    Get.put(cancelledTaskController());
    Get.put(addNewTaskController());
    Get.put(taskCardController());
    Get.put(forgotPassController());
    Get.put(pinVerifyController());
    Get.put(resetPassController());
    Get.put(profileController());
  }

}