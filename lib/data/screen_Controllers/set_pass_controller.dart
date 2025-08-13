import 'package:get/get.dart';

import '../../ui/utils/toastMessage.dart';

import '../models/network_caller.dart';
import '../services/network-response.dart';
import '../utils/all_urls.dart';



class resetPassController extends GetxController{

  String? _errorMsg;

  String? get errorMsg => _errorMsg;

  bool _inProgress = false;

  bool get inProgress => _inProgress;

  bool _isSuccess = false;

  bool get isSuccess => _isSuccess;

  Future<bool> resetPass(String email, String otp, String password)async{

    bool isSuccess = false;

    _inProgress = true;
    update();

    Map<String,dynamic> data = {
      'email' : email,
      'OTP' : otp,
      'password' : password
    };

    networkResponse response = await networkCaller.postRequest(
        url: Urls.resetPass,
        body: data
    );
    print(response.statusCode);

    if(response.isSuccess){
      isSuccess = true;
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