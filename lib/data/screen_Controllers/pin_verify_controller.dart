import 'package:get/get.dart';

import '../../ui/utils/toastMessage.dart';
import '../models/network_caller.dart';
import '../services/network-response.dart';


class pinVerifyController extends GetxController{

  String _enteredOtp = '';

  String get enteredOtp => _enteredOtp;

  set enteredOtp(String value) {
    _enteredOtp = value;
    update();
  }

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  String? _errorMsg;

  String? get errorMsg => _errorMsg;

  bool _inProgress = false;

  bool get inProgress => _inProgress;

  bool _isSuccess = false;

  bool get isSuccess => _isSuccess;

  Future<bool> verifyPin(String email)async{

    bool isSuccess = false;

    if (_enteredOtp.length != 6) {
      update(
          [
            _errorMessage = "Please enter a valid 6-digit OTP."
          ]
      );

    }

    _inProgress = true;
    _errorMessage=null;
    update();

    final String url = 'http://35.73.30.144:2005/api/v1/RecoverVerifyOtp/${email}/$_enteredOtp';

    networkResponse response = await networkCaller.getRequest(url);
    print(response.statusCode);

    if(response.isSuccess){
      isSuccess = true;
    }
    else{

      ErrorToast('Wrong pin');
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}