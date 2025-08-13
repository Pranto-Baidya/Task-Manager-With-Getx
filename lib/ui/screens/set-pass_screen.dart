
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled3/data/auth_controllers/authentication.dart';
import 'package:untitled3/data/models/network_caller.dart';
import 'package:untitled3/data/screen_Controllers/set_pass_controller.dart';
import 'package:untitled3/data/services/network-response.dart';
import 'package:untitled3/data/utils/all_urls.dart';
import 'package:untitled3/ui/screens/sign-in_screen.dart';

import 'package:untitled3/ui/utils/app_Colors.dart';
import 'package:untitled3/ui/utils/spinkit.dart';
import 'package:untitled3/ui/utils/toastMessage.dart';
import 'package:untitled3/ui/widgets/screen_background.dart';

class setPassScreen extends StatefulWidget {
  final String email;
  final String otp;
  const setPassScreen({super.key, required this.email, required this.otp});

  @override
  State<setPassScreen> createState() => _setPassScreenState();
}

class _setPassScreenState extends State<setPassScreen> {

  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>() ;

  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  final resetPassController controller = Get.find<resetPassController>();

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
              height: 180,
            ),
            Text(
              'Set password',
              style: textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.themeColor,
              )
            ),
            SizedBox(
              height: 15,
            ),
            Text(
                'Minimum length of password should be 8 characters with the combination of letters & numbers',
                style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                     color: Colors.black54
                )
            ),
            SizedBox(
              height: 24,
            ),
            _buildSetPassForm(),
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

  Widget _buildSetPassForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [

          TextFormField(
            validator: (value){
              if(value!.isEmpty){
                return 'Please enter your new password';
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
            validator: (value){
              if(value!.isEmpty){
                return 'Please confirm your password';
              }
              if(value!=_passController.text){
                return 'Passwords do not match';
              }
              return null;
            },
            controller: _confirmPassController,
            cursorColor: AppColors.themeColor,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Confirm Password',
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GetBuilder<resetPassController>(
            builder: (controller) {
              return ElevatedButton(
                onPressed: _onTapConfirmButton,
                child: !controller.inProgress? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Confirm',
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
                ):Center(child: spinKit.normalLoader(),),
              );
            }
          ),
        ],
      ),
    );
  }

  Future<void> _resetPassword()async{

    final bool result = await controller.resetPass(widget.email, widget.otp, _passController.text);

    if(result){
     SuccessToast('Password has been reset successfully');
     Navigator.push(context, MaterialPageRoute(builder: (context)=>signInScreen()));
   }
  }

  void _onTapConfirmButton() {
    if(_formKey.currentState!.validate()){
      _resetPassword();
    }
  }
  void _onTapSignInButton() {
    Get.to(signInScreen(),transition: Transition.leftToRightWithFade);
  }
}
