import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled3/data/models/network_caller.dart';
import 'package:untitled3/data/screen_Controllers/add_new_task_controller.dart';
import 'package:untitled3/data/services/network-response.dart';
import 'package:untitled3/data/utils/all_urls.dart';
import 'package:untitled3/ui/utils/app_Colors.dart';
import 'package:untitled3/ui/utils/spinkit.dart';
import 'package:untitled3/ui/utils/toastMessage.dart';
import 'package:untitled3/ui/widgets/TM_Appbar.dart';
import 'package:untitled3/ui/widgets/screen_background.dart';
import 'package:intl/intl.dart';

class addNewTask extends StatefulWidget {
  const addNewTask({super.key});

  @override
  State<addNewTask> createState() => _addNewTaskState();
}

class _addNewTaskState extends State<addNewTask> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final addNewTaskController controller = Get.find<addNewTaskController>();


  bool shouldRefreshPreviousPage = false;


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result){
        if(didPop){
          return;
        }
        Navigator.pop(context,shouldRefreshPreviousPage);
      },
      child: Scaffold(
        backgroundColor: Color(0xFFFEFFF1),
        resizeToAvoidBottomInset: false,
        appBar: TM_AppBar(
      
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 42,),
                  Text('Add new task',style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Color(0xFF003366),
                    fontWeight: FontWeight.w500,
                  ),
                  ),
                  const SizedBox(height: 24,),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please add a title of your task';
                      }
                      return null;
                    },
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Title'
                    ),
                    cursorColor: AppColors.themeColor,
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please write a description of your task';
                      }
                      return null;
                    },
                    controller: _desController,
                    maxLines: 8,
                    decoration: InputDecoration(
                        hintText: 'Description'
                    ),
                    cursorColor: AppColors.themeColor,
                  ),
                  const SizedBox(height: 15,),
                  GetBuilder<addNewTaskController>(
                    builder: (controller) {
                      return ElevatedButton(
                          onPressed: _onTapAddTask,
                          child: !controller.inProgress? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Add task',style: TextStyle(color: Color(0xFFFEFFF1),fontSize: 18,),),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.arrow_circle_right_outlined,
                                color: Color(0xFFFEFFF1),
                              )
                            ],
                          ): Center(
                            child: spinKit.normalLoader(),
                          )
                      );
                    }
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _onTapAddTask(){
    if(_key.currentState!.validate()){
      _addTask();
      _clearFields();
    }
  }
  void _clearFields(){
    _titleController.clear();
    _desController.clear();
  }

  Future<void> _addTask() async {

    final bool result = await controller.addNewTask(
        _titleController.text.trim(),
        _desController.text.trim()
    );

    if (result) {
      shouldRefreshPreviousPage = true;
    }
  }
}
