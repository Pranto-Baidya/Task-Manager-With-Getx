import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:untitled3/data/models/network_caller.dart';
import 'package:untitled3/data/services/network-response.dart';

import 'package:untitled3/data/utils/all_urls.dart';
import 'package:untitled3/ui/screens/sign-in_screen.dart';

import 'package:untitled3/ui/utils/app_Colors.dart';
import 'package:untitled3/ui/utils/spinkit.dart';
import 'package:untitled3/ui/utils/toastMessage.dart';
import 'package:untitled3/ui/widgets/screen_background.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../data/screen_Controllers/sign_up_controller.dart';

class signUpScreen extends StatefulWidget {
  const signUpScreen({super.key});

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>() ;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  final signUpController controller = Get.find<signUpController>();


  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {

    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
        backgroundColor: Color(0xFFFEFFF1),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              'Join with us',
              style: textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.themeColor,
              )
            ),
            SizedBox(
              height: 24,
            ),
            _buildSignUpForm(),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 8,
            ),
            _buildRichText()
          ],
        ),
                  ),
                )
    );
  }

  Widget _buildRichText() {
    return Center(
      child: RichText(
          text: TextSpan(
              text: "Already have an account?",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              children: [
            TextSpan(
                text: " Sign In",
                style: TextStyle(color: AppColors.themeColor,fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton)
          ])),
    );
  }

  Widget _buildSignUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value){

              String? nonCaseSensitive = value?.toLowerCase();

              if(nonCaseSensitive!.isEmpty) {
                return 'Please enter an email address';
              }
              if(!nonCaseSensitive.contains('@')){
                return 'Please enter a valid email address';
              }
              if(!nonCaseSensitive.contains('.com')){
                return 'Email address must end with ".com "';
              }

              return null;
            },
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: AppColors.themeColor,
            decoration: InputDecoration(
              hintText: 'Email',
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value){
              String? nonCaseSensitive = value?.toLowerCase();
              if(nonCaseSensitive!.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
            controller: _firstNameController ,
            keyboardType: TextInputType.text,
            cursorColor: AppColors.themeColor,
            decoration: InputDecoration(
              hintText: 'First name',
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value){
              String? nonCaseSensitive = value?.toLowerCase();

              if(nonCaseSensitive!.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
            controller: _lastNameController,
            keyboardType: TextInputType.text,
            cursorColor: AppColors.themeColor,
            decoration: InputDecoration(
              hintText: 'Last name',
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value){
              if(value!.isEmpty) {
                return 'Please enter your mobile number';
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value){
              if(value!.isEmpty) {
                return 'Please enter your password';
              }
              if(value.length<6){
                return 'Password must contain a minimum of 6 characters';
              }
              return null;
            },
            controller: _passController,
            cursorColor: AppColors.themeColor,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
            ),
          ),
          SizedBox(
            height: 15,
          ),

          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value){
              if(value!.isEmpty ) {
                return 'Enter password first';
              }
              if(value!= _passController.text){
                return 'Passwords do not match';
              }
              return null;
            },
            controller: _confirmPassController,
            cursorColor: AppColors.themeColor,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Confirm password',
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GetBuilder<signUpController>(
            builder: (controller) {
              return ElevatedButton(
                onPressed: _onTapRegisterButton,
                child: !controller.inProgress?Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Register',
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
                ) : Center(
                  child: spinKit.normalLoader()
                ),
              );
            }
          ),
        ],
      ),
    );

  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _onTapRegisterButton() {
    if(_formKey.currentState!.validate()){
     signUp();
    }
  }

  Future<void> signUp()async {
    final bool result = await controller.signUp(
        _emailController.text.trim(),
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        _mobileController.text.trim(),
        _passController.text
    );

    if (result) {
      SuccessToast('Registration successful');
    }

  }
  void _onTapSignInButton() {
    Get.to(signInScreen(),transition: Transition.leftToRightWithFade);
  }

}
