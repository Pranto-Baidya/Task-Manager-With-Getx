import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:untitled3/data/models/network_caller.dart';
import 'package:untitled3/data/screen_Controllers/pin_verify_controller.dart';
import 'package:untitled3/data/services/network-response.dart';
import 'package:untitled3/ui/screens/set-pass_screen.dart';
import 'package:untitled3/ui/screens/sign-in_screen.dart';
import 'package:untitled3/ui/utils/app_Colors.dart';
import 'package:untitled3/ui/utils/spinkit.dart';
import 'package:untitled3/ui/utils/toastMessage.dart';
import 'package:untitled3/ui/widgets/screen_background.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class pinVerificationScreen extends StatefulWidget {
  final String email;

  const pinVerificationScreen({super.key, required this.email});

  @override
  State<pinVerificationScreen> createState() => _pinVerificationScreenState();
}

class _pinVerificationScreenState extends State<pinVerificationScreen> {
  //String _enteredOtp = '';
  //bool _isLoading = false;
  //String? _errorMessage;

  final pinVerifyController controller = Get.find<pinVerifyController>();

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
              SizedBox(height: 180),
              Text(
                'Pin verification',
                style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500,color: AppColors.themeColor,),
              ),
              SizedBox(height: 15),
              Text(
                'A 6-digit verification pin has been sent to your email address',
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 24),
              _buildForgotPassForm(),
              if (controller.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    controller.errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: 40),
              _buildRichText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRichText() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "Already have an account?",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          children: [
            TextSpan(
              text: " Sign In",
              style: TextStyle(color: AppColors.themeColor,fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForgotPassForm() {
    return Column(
      children: [
        GetBuilder<pinVerifyController>(
          builder: (controller) {
            return PinCodeTextField(
              length: 6,
              obscureText: false,
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              onChanged: (value) {
                controller.enteredOtp = value;
              },
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
                inactiveFillColor: Colors.white,
                selectedColor: AppColors.themeColor,
                selectedFillColor: Colors.white,
              ),
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              appContext: context,
            );
          }
        ),
        SizedBox(height: 15),
        GetBuilder<pinVerifyController>(
          builder: (controller) {
            return ElevatedButton(
              onPressed:  _onTapVerifyButton,
              child:  !controller.inProgress? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Verify', style: TextStyle(color: Color(0xFFFEFFF1), fontSize: 18)),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_circle_right_outlined, color: Color(0xFFFEFFF1)),
                ],
              ):Center(child: spinKit.normalLoader(),),
            );
          }
        ),
      ],
    );
  }

  void _onTapVerifyButton() async {

    final bool result = await controller.verifyPin(widget.email);

    if(result){
      SuccessToast('Pin verification was successful');
      Get.off(setPassScreen(email: widget.email, otp: controller.enteredOtp),transition: Transition.leftToRightWithFade);
    }
  }

  void _onTapSignInButton() {
      Get.to(signInScreen(),transition: Transition.leftToRightWithFade);
  }
}
