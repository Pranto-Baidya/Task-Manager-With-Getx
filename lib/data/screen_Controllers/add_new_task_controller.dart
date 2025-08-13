import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../ui/utils/toastMessage.dart';
import '../models/network_caller.dart';
import '../services/network-response.dart';
import '../utils/all_urls.dart';



class addNewTaskController extends GetxController{

  String? _errorMsg;

  String? get errorMsg => _errorMsg;

  bool _inProgress = false;

  bool get inProgress => _inProgress;

  bool _isSuccess = false;

  bool get isSuccess => _isSuccess;

  Future<bool> addNewTask(String title, String description)async{

    bool isSuccess = false;
    _inProgress = true;
    update();

    String createdDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "New",
      "createdDate": createdDate
    };

    networkResponse response = await networkCaller.postRequest(
        url: Urls.addTask,
        body:  requestBody
    );
    print(response.statusCode);

    if(response.isSuccess){
      isSuccess = true;
      SuccessToast('Task added successfully');
    }
    else{
      _errorMsg = response.errorMsg;
      ErrorToast(_errorMsg);
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}