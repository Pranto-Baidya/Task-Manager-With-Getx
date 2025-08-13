import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:untitled3/data/models/network_caller.dart';
import 'package:untitled3/data/screen_Controllers/forgot_pass_controller.dart';
import 'package:untitled3/data/services/network-response.dart';
import 'package:untitled3/ui/screens/pin-verification_screen.dart';
import 'package:untitled3/ui/screens/sign-in_screen.dart';
import 'package:untitled3/ui/utils/app_Colors.dart';
import 'package:untitled3/ui/utils/page_transition.dart';
import 'package:untitled3/ui/utils/spinkit.dart';
import 'package:untitled3/ui/utils/toastMessage.dart';
import 'package:untitled3/ui/widgets/screen_background.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  bool inProgress = false;

  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final forgotPassController controller = Get.find<forgotPassController>();

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
              const SizedBox(height: 180),
              Text(
                'Your email address',
                style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500,color: AppColors.themeColor,),
              ),
              const SizedBox(height: 15),
              Text(
                'A 6-digit verification pin will be sent to your email address',
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 24),
              _buildForgotPassForm(),
              const SizedBox(height: 40),
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email address';
              }
              return null;
            },
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: AppColors.themeColor,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
          ),
          const SizedBox(height: 15),
          GetBuilder<forgotPassController>(
            builder: (controller) {
              return ElevatedButton(
                onPressed: _onTapSubmitButton,
                child: !controller.inProgress? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Submit',
                      style: TextStyle(color: Color(0xFFFEFFF1), fontSize: 18),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.arrow_circle_right_outlined,
                      color: Color(0xFFFEFFF1),
                    ),
                  ],
                ) : Center(child: spinKit.normalLoader(),),
              );
            }
          ),
        ],
      ),
    );
  }

  Future<void> verifyEmail() async {
    final String email = _emailController.text.trim();

    final bool result = await controller.forgotPass(email);

    if(result){
      SuccessToast('Check your email for the pin code');
      Get.to(pinVerificationScreen(email: email),transition: Transition.leftToRightWithFade);
    }
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      verifyEmail();
    }
  }

  void _onTapSignInButton() {
    Get.to(signInScreen(),transition: Transition.leftToRightWithFade);
  }
}
