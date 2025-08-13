import 'package:get/get.dart';

import '../../ui/utils/toastMessage.dart';
import '../auth_controllers/authentication.dart';
import '../models/login_model.dart';
import '../models/network_caller.dart';
import '../services/network-response.dart';
import '../utils/all_urls.dart';
import 'package:untitled3/controller_binder.dart';


class signInController extends GetxController{

   String? _errorMsg;

   String? get errorMsg => _errorMsg;

   bool _inProgress = false;

   bool get inProgress => _inProgress;

   bool _isSuccess = false;

   bool get isSuccess => _isSuccess;

   Future<bool> signIn(String email, String password)async{

     bool isSuccess = false;

     _inProgress = true;
     update();

     Map<String, dynamic> requestBody = {
       "email": email,
       "password": password
     };

     networkResponse response = await networkCaller.postRequest(
         url: Urls.login,
         body:  requestBody
     );
     print(response.statusCode);

     if(response.isSuccess){

       LoginModel loginModel = LoginModel.fromJson(response.responseData);

       await authentication.saveAccessToken(loginModel.token!);
       await authentication.saveUserData(loginModel.data!);

       isSuccess = true;

       SuccessToast('Login successful');
     }
     else{
       ErrorToast('Invalid login credentials');
     }
     _inProgress = false;
     update();
     return isSuccess;
   }
}