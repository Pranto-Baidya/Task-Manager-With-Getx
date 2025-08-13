import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled3/data/models/network_caller.dart';
import 'package:untitled3/data/models/taskModel.dart';
import 'package:untitled3/data/models/taskStatusCountModel.dart';
import 'package:untitled3/data/models/task_Status_Model.dart';
import 'package:untitled3/data/models/task_list_model.dart';
import 'package:untitled3/data/screen_Controllers/cancelledTask_controller.dart';
import 'package:untitled3/data/services/network-response.dart';
import 'package:untitled3/data/utils/all_urls.dart';
import 'package:untitled3/ui/utils/app_Colors.dart';
import 'package:untitled3/ui/utils/spinkit.dart';
import 'package:untitled3/ui/utils/toastMessage.dart';
import 'package:untitled3/ui/widgets/taskCard.dart';
import 'package:untitled3/ui/widgets/taskSummaryCard.dart';

class cancelledTaskScreen extends StatefulWidget {
  const cancelledTaskScreen({super.key});

  @override
  State<cancelledTaskScreen> createState() => _cancelledTaskScreenState();
}

class _cancelledTaskScreenState extends State<cancelledTaskScreen> {

  bool refreshCancelledTaskListInProgress = false;

  final cancelledTaskController controller = Get.find<cancelledTaskController>();

  @override
  void initState() {
    super.initState();
    _refreshData();
    //getCancelledTaskList();
    //getTaskStatusCount();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppColors.themeColor,
      color: Color(0xFFFEFFF1),
      onRefresh: _refreshData,
      child: Scaffold(
        backgroundColor: Colors.red.shade50,
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
                child: GetBuilder<cancelledTaskController>(
                  builder: (controller) {
                    return !controller.inProgress? ListView.separated(
                      itemCount: controller.taskList.length,
                      itemBuilder: (context,index){
                        return taskCard(model: controller.taskList[index],
                          onRefreshList:_refreshData
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

  Future<void> getCancelledTaskList ()async{

    final bool result = await controller.getCancelledTaskList();

    if(result == false){
      ErrorToast(controller.errorMsg);
    }

  }

  Future<void> getTaskStatusCount() async {
    await controller.getTaskStatusCount();
  }



  Widget _buildRow() {
    return GetBuilder<cancelledTaskController>(
        builder: (controller) {
          return !controller.getTaskStatusCountListInProgress
              ? Row(
            children: [
              Expanded(
                child: GetBuilder<cancelledTaskController>(
                    builder: (controller) {
                      return TaskSummaryCard(
                        count: controller.cancelledTaskCount,
                        title: 'Tasks are cancelled',
                        color: Colors.red,
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


