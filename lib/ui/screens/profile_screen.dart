import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled3/data/auth_controllers/authentication.dart';

import 'package:untitled3/data/screen_Controllers/profile_screen_controller.dart';

import 'package:untitled3/ui/utils/app_Colors.dart';

import 'package:untitled3/ui/utils/spinkit.dart';
import 'package:untitled3/ui/utils/toastMessage.dart';
import 'package:untitled3/ui/widgets/TM_Appbar.dart';

import 'package:image_picker/image_picker.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({
    super.key,
  });

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {



  @override
  void initState() {
    super.initState();
    _setUserData();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final profileController controller = Get.find<profileController>();

  XFile? selectedImage;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;


    return PopScope(
      onPopInvokedWithResult: (_,__){
        controller.selectedImage = null;
      },
      child: Scaffold(
          backgroundColor: Color(0xFFFEFFF1),
          appBar: TM_AppBar(
            isProfileScreenOpen: true,
          ),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text('Update profile',
                        style: textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.themeColor)),
                    SizedBox(
                      height: 24,
                    ),
                    _buildPhotoPicker(),
                    SizedBox(
                      height: 15,
                    ),
                    _buildSignUpForm(),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget _buildPhotoPicker() {
    return InkWell(
      onTap: controller.pickImage,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border(
              top: BorderSide(color: Color(0xFF003366)),
              right: BorderSide(color: Color(0xFF003366)),
              bottom: BorderSide(color: Color(0xFF003366)),
            )),
        child: Row(
          children: [
            Container(
              width: 100,
              decoration: BoxDecoration(
                  color: Color(0xFF003366),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  )),
              child: Center(
                  child: Text(
                'Photo',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              )),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child:  GetBuilder<profileController>(
                builder: (controller) {
                  return Text(
                       controller.getSelectedPhotoTitle(),
                        style: TextStyle(color: Colors.black45),
                      );
                }
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    await controller.pickImage();
  }

  Widget _buildSignUpForm() {
    return Column(
      children: [
        TextFormField(
          enabled: false,
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.green,
          decoration: InputDecoration(
            hintText: 'Email',
          ),
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please type your first name';
            }
            return null;
          },
          controller: _firstNameController,
          keyboardType: TextInputType.text,
          cursorColor: AppColors.themeColor,
          decoration: InputDecoration(
            hintText: 'First Name',
          ),
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please type your last name';
            }
            return null;
          },
          controller: _lastNameController,
          keyboardType: TextInputType.text,
          cursorColor: AppColors.themeColor,
          decoration: InputDecoration(
            hintText: 'Last Name',
          ),
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please type your new mobile number';
            }
            return null;
          },
          controller: _mobileController,
          keyboardType: TextInputType.phone,
          cursorColor: AppColors.themeColor,
          decoration: InputDecoration(
            hintText: 'Mobile',
          ),
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          controller: passController,
          cursorColor: AppColors.themeColor,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
          ),
        ),
        SizedBox(
          height: 15,
        ),
        GetBuilder<profileController>(
          builder: (controller) {
            return ElevatedButton(
              onPressed: _onTapUpdateButton,
              child: !controller.inProgress
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Update',
                          style: TextStyle(color: Color(0xFFFEFFF1), fontSize: 18),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Color(0xFFFEFFF1),
                        )
                      ],
                    )
                  : Center(
                      child: spinKit.normalLoader(),
                    ),
            );
          }
        )
      ],
    );
  }

  Future<void> _updateProfile() async {

    final bool result = await controller.updateProfile(
        _emailController.text.trim(),
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        _mobileController.text.trim(),
         passController.text
    );
    if (result) {
      SuccessToast('Profile has been updated successfully');
    }

  }

  void _setUserData() {
    _emailController.text = authentication.userData?.email ?? '';
    _firstNameController.text = authentication.userData?.firstName ?? '';
    _lastNameController.text = authentication.userData?.lastName ?? '';
    _mobileController.text = authentication.userData?.mobile ?? '';
  }

  void _onTapUpdateButton() {
    if (_formKey.currentState!.validate()) {
      _updateProfile();
    }
  }
}
