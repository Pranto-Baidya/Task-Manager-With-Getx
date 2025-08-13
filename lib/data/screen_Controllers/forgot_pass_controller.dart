import 'package:get/get.dart';

import '../../ui/utils/toastMessage.dart';
import '../models/network_caller.dart';
import '../services/network-response.dart';


class forgotPassController extends GetxController{

  String? _errorMsg;

  String? get errorMsg => _errorMsg;

  bool _inProgress = false;

  bool get inProgress => _inProgress;

  bool _isSuccess = false;

  bool get isSuccess => _isSuccess;

  Future<bool> forgotPass(String email)async{

    bool isSuccess = false;

    _inProgress = true;
    update();

    final String url = 'http://35.73.30.144:2005/api/v1/RecoverVerifyEmail/$email';

    networkResponse response = await networkCaller.getRequest(url);
    print(response.statusCode);

    if(response.isSuccess){
      isSuccess = true;
    }
    else{
      ErrorToast('Email is not registered');
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}