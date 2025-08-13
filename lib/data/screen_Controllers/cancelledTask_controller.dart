import 'package:get/get.dart';

import '../../ui/utils/toastMessage.dart';
import '../auth_controllers/authentication.dart';
import '../models/login_model.dart';
import '../models/network_caller.dart';
import '../models/taskModel.dart';
import '../models/taskStatusCountModel.dart';
import '../models/task_Status_Model.dart';
import '../models/task_list_model.dart';
import '../services/network-response.dart';
import '../utils/all_urls.dart';
import 'package:untitled3/controller_binder.dart';


class cancelledTaskController extends GetxController{

  bool _refreshCancelledTaskListInProgress = false;

  bool get refreshCancelledTaskListInProgress => _refreshCancelledTaskListInProgress;

  int cancelledTaskCount = 0;

  List<TaskStatusModel> _taskStatusCountList = [];

  List<TaskStatusModel> get taskStatusCountList=> _taskStatusCountList;

  bool _getTaskStatusCountListInProgress = false;

  bool get getTaskStatusCountListInProgress => _getTaskStatusCountListInProgress;

  List<taskModel> _taskList = [];

  List<taskModel> get taskList => _taskList;

  String? _errorMsg;

  String? get errorMsg => _errorMsg;

  bool _inProgress = false;

  bool get inProgress => _inProgress;

  bool _isSuccess = false;

  bool get isSuccess => _isSuccess;

  Future<void> refreshData() async {

    _refreshCancelledTaskListInProgress = true;
    update();
    await getCancelledTaskList();
    await getTaskStatusCount();
    _refreshCancelledTaskListInProgress = false;
    update();
  }

  Future<bool> getCancelledTaskList()async{

    bool isSuccess = false;

    _inProgress = true;
    update();

    final networkResponse response = await networkCaller.getRequest(Urls.cancelledTask);

    if (response.isSuccess) {
      final taskListModel list = taskListModel.fromJson(response.responseData);

      _taskList = list.taskList ?? [];
      update();
      isSuccess = true;

    } else {
      _errorMsg = response.errorMsg;
      ErrorToast(_errorMsg);
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> getTaskStatusCount() async {
    bool isSuccess = false;
    _taskStatusCountList.clear();
    _getTaskStatusCountListInProgress = true;
    update();

    final networkResponse response = await networkCaller.getRequest(Urls.countTask);

    if (response.isSuccess) {
      final TaskStatusCount countList = TaskStatusCount.fromJson(response.responseData);
      _taskStatusCountList = countList.taskStatusCountList ?? [];

      cancelledTaskCount = 0;

      for (var status in _taskStatusCountList) {
        if (status.sId == "Cancelled") {
          cancelledTaskCount = status.sum ?? 0;
          break;
        }
      }
    } else {
      ErrorToast('Something went wrong');
    }
    _taskStatusCountList.clear();
    _getTaskStatusCountListInProgress = false;

    update();
    return isSuccess;
  }
}