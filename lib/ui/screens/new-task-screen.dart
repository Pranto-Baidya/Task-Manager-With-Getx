import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled3/data/screen_Controllers/newTask_controller.dart';
import 'package:untitled3/ui/screens/add-new-task-screen.dart';
import 'package:untitled3/ui/utils/app_Colors.dart';
import 'package:untitled3/ui/utils/spinkit.dart';
import 'package:untitled3/ui/utils/toastMessage.dart';
import 'package:untitled3/ui/widgets/taskCard.dart';
import 'package:untitled3/ui/widgets/taskSummaryCard.dart';



class newTaskScreen extends StatefulWidget {
  const newTaskScreen({super.key});

  @override
  State<newTaskScreen> createState() => _newTaskScreenState();
}

class _newTaskScreenState extends State<newTaskScreen> {

  final newTaskController controller = Get.find<newTaskController>();

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppColors.themeColor,
      color: Color(0xFFFEFFF1),
      onRefresh: _refreshData,
      child: Scaffold(
        backgroundColor: Colors.blue.shade50,
        //backgroundColor: Color(0xFFFEFFF1),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _buildRow(),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: GetBuilder<newTaskController>(
                builder: (controller) {
                  return !controller.inProgress
                      ? ListView.separated(
                    itemCount: controller.taskList.length,
                    itemBuilder: (context, index) {
                      return taskCard(
                        model: controller.taskList[index],
                        onRefreshList: _refreshData,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 8);
                    },
                  )
                      : Center(child: spinKit.mainLoader());
                }
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 20, right: 10),
          child:  FloatingActionButton(
                onPressed: () async {
                  final bool? shouldRefresh = await Get.to(addNewTask(),transition: Transition.leftToRightWithFade);
                  if (shouldRefresh == true) {
                    _refreshData();
                  }
                },
                backgroundColor: AppColors.themeColor,
                child: const Icon(Icons.add, color: Color(0xFFFEFFF1)),
                shape: const CircleBorder(),
              ),
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    await controller.refreshData();
  }

  Future<void> getNewTaskList() async {
    final bool result = await controller.getNewTaskList();

    if (result==false) {
      ErrorToast(controller.errorMsg);
    } 
  }

  Future<void> getTaskStatusCount() async {
    await controller.getTaskStatusCount();
  }

  Widget _buildRow() {
    return GetBuilder<newTaskController>(
      builder: (controller) {
        return !controller.getTaskStatusCountListInProgress
            ? Row(
          children: [
            Expanded(
              child: GetBuilder<newTaskController>(
                builder: (controller) {
                  return TaskSummaryCard(
                    count: controller.newTaskCount,
                    title: 'Newly added tasks',
                    color: Colors.blue,
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
