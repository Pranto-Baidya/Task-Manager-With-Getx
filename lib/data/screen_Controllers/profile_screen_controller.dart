import 'dart:convert';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../ui/utils/toastMessage.dart';
import '../auth_controllers/authentication.dart';
import '../models/network_caller.dart';
import '../models/user_model.dart';
import '../services/network-response.dart';
import '../utils/all_urls.dart';


class profileController extends GetxController{

  XFile? selectedImage;

  String? _errorMsg;

  String? get errorMsg => _errorMsg;

  bool _inProgress = false;

  bool get inProgress => _inProgress;

  bool _isSuccess = false;

  bool get isSuccess => _isSuccess;

  String getSelectedPhotoTitle() {
    if (selectedImage != null) {
      return selectedImage!.name;
    }
    return 'Select photo';
  }

  Future<void> pickImage() async {
    ImagePicker _imagePicker = ImagePicker();
    XFile? pickedImage =
    await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      selectedImage = pickedImage;
      update();
    }
  }

  Future<bool> updateProfile(String email, String firstName,String lastName,String mobile,String passController)async{

    bool isSuccess = false;

    _inProgress = true;
    update();

    Map<String,dynamic> requestBody = {
      "email":email,
      "firstName":firstName,
      "lastName":lastName,
      "mobile":mobile,
    };

    if (passController.isNotEmpty) {
      requestBody['password'] = passController;
    }
    if (selectedImage != null) {
      List<int> imageBytes = await selectedImage!.readAsBytes();
      String convertedImage = base64Encode(imageBytes);
      requestBody['photo'] = convertedImage;
    }

    networkResponse response = await networkCaller.postRequest(
        url: Urls.updateProfile,
        body:  requestBody
    );
    print(response.statusCode);

    if(response.isSuccess){
      isSuccess = true;
      userModel model = userModel.fromJson(requestBody);
      authentication.saveUserData(model);
      selectedImage = null;

    }
    else{
      _errorMsg = response.errorMsg;
      ErrorToast(_errorMsg);
      //selectedImage = null;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}

