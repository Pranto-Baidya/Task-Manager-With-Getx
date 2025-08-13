import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled3/data/models/network_caller.dart';
import 'package:untitled3/data/models/taskModel.dart';
import 'package:untitled3/data/models/taskStatusCountModel.dart';
import 'package:untitled3/data/models/task_Status_Model.dart';
import 'package:untitled3/data/models/task_list_model.dart';
import 'package:untitled3/data/screen_Controllers/completedTask_controller.dart';
import 'package:untitled3/data/services/network-response.dart';
import 'package:untitled3/data/utils/all_urls.dart';
import 'package:untitled3/ui/screens/add-new-task-screen.dart';
import 'package:untitled3/ui/screens/new-task-screen.dart';
import 'package:untitled3/ui/utils/app_Colors.dart';
import 'package:untitled3/ui/utils/spinkit.dart';
import 'package:untitled3/ui/utils/toastMessage.dart';
import 'package:untitled3/ui/widgets/screen_background.dart';
import 'package:untitled3/ui/widgets/taskCard.dart';
import 'package:untitled3/ui/widgets/taskSummaryCard.dart';

class completedTaskScreen extends StatefulWidget {
  const completedTaskScreen({super.key});

  @override
  State<completedTaskScreen> createState() => _completedTaskScreenState();
}

class _completedTaskScreenState extends State<completedTaskScreen> {

  final completedTaskController controller = Get.find<completedTaskController>();

  @override
  void initState() {
    super.initState();
    _refreshData();
    //getCompletedTaskList();
    //getTaskStatusCount();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppColors.themeColor,
      color: Color(0xFFFEFFF1),
      onRefresh: _refreshData,
      child: Scaffold(
         backgroundColor: Colors.green.shade50,
        //backgroundColor: Color(0xFFFEFFF1),
        body: Column(
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8),
              child: _buildRow(),
            ),
            const SizedBox(height: 15,),
            Expanded(
                child: GetBuilder<completedTaskController>(
                  builder: (controller) {
                    return !controller.inProgress? ListView.separated(
                      itemCount: controller.taskList.length,
                      itemBuilder: (context,index){
                        return taskCard(model: controller.taskList[index],
                          onRefreshList: _refreshData
                        );
                      },
                      separatorBuilder: (context,index){
                        return SizedBox(
                          height: 8,
                        );
                      },
                    ):Center(
                      child: spinKit.mainLoader(),
                    );
                  }
                )
            )

          ],
        ),

      ),
    );
  }

  Future<void> _refreshData() async {
    await controller.refreshData();
  }


  Future<void> getCompletedTaskList ()async{

    final bool result = await controller.getCompletedTaskList();

    if(result==false){
      ErrorToast(controller.errorMsg);
    }
  }

  Future<void> getTaskStatusCount() async {
    await controller.getTaskStatusCount();
  }

  Widget _buildRow() {
    return GetBuilder<completedTaskController>(
        builder: (controller) {
          return !controller.getTaskStatusCountListInProgress
              ? Row(
            children: [
              Expanded(
                child: GetBuilder<completedTaskController>(
                    builder: (controller) {
                      return TaskSummaryCard(
                        count: controller.completedTaskCount,
                        title: 'Tasks are completed',
                        color: Colors.green,
                        textColor: Colors.white,
                      );
                    }
                ),
              ),
            ],
          ) : Center(child: spinKit.mainLoader());
        }
    );
  }
}



