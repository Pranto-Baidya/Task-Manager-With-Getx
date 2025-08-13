import 'dart:ui';

import 'package:get/get.dart';

import '../../ui/utils/toastMessage.dart';
import '../auth_controllers/authentication.dart';
import '../models/login_model.dart';
import '../models/network_caller.dart';
import '../models/taskModel.dart';
import '../services/network-response.dart';
import '../utils/all_urls.dart';
import 'package:untitled3/controller_binder.dart';


class taskCardController extends GetxController {
  String? _errorMsg;

  String? get errorMsg => _errorMsg;

  bool _inProgress = false;

  bool get inProgress => _inProgress;


  Map<String, bool> deleteInProgressMap = {};

  Future<bool> changeStatus(
      String taskId, String newStatus, VoidCallback onRefreshList) async {
    _inProgress = true;
    update();

    final networkResponse response = await networkCaller.getRequest(
      Urls.changeStatus(taskId, newStatus),
    );

    _inProgress = false;
    update();

    if (response.isSuccess) {
      return true;
    } else {
      _errorMsg = response.errorMsg;
      ErrorToast(_errorMsg);
      return false;
    }
  }

  Future<bool> onTapDelete(String taskId) async {
    deleteInProgressMap[taskId] = true;
    update();

    final networkResponse response = await networkCaller.getRequest(
      Urls.deleteTask(taskId),
    );

    if (response.isSuccess) {
      deleteInProgressMap.remove(taskId);
      update();
      return true;
    } else {
      _errorMsg = response.errorMsg;
      ErrorToast(_errorMsg);
      deleteInProgressMap[taskId] = false;
      update();
      return false;
    }
  }

  bool isDeleteInProgress(String taskId) {
    return deleteInProgressMap[taskId] ?? false;
  }
}

