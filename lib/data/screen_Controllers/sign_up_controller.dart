import 'package:get/get.dart';

import '../../ui/utils/toastMessage.dart';
import '../auth_controllers/authentication.dart';
import '../models/login_model.dart';
import '../models/network_caller.dart';
import '../services/network-response.dart';
import '../utils/all_urls.dart';
import 'package:untitled3/controller_binder.dart';


class signUpController extends GetxController{

  String? _errorMsg;

  String? get errorMsg => _errorMsg;

  bool _inProgress = false;

  bool get inProgress => _inProgress;

  bool _isSuccess = false;

  bool get isSuccess => _isSuccess;

  Future<bool> signUp(String email, String firstName,String lastName,String mobile, String password)async{

    bool isSuccess = false;

    _inProgress = true;
    update();

    Map<String,dynamic> requestBody = {

      "email":email,
      "firstName":firstName,
      "lastName":lastName,
      "mobile":mobile,
      "password":password

    };

    networkResponse response = await networkCaller.postRequest(
        url: Urls.registration,
        body:  requestBody
    );
    print(response.statusCode);

    if(response.isSuccess){

      isSuccess = true;
      SuccessToast('Registration successful');
    }
    else{
      ErrorToast('Something went wrong');
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}