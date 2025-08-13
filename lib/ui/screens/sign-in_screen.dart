import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled3/data/auth_controllers/authentication.dart';
import 'package:untitled3/data/models/login_model.dart';
import 'package:untitled3/data/models/network_caller.dart';
import 'package:untitled3/data/models/user_model.dart';
import 'package:untitled3/data/screen_Controllers/sign_in_controller.dart';
import 'package:untitled3/data/services/network-response.dart';
import 'package:untitled3/data/utils/all_urls.dart';
import 'package:untitled3/ui/screens/forgot-pass_screen.dart';
import 'package:untitled3/ui/screens/main_bottom_nav_screen.dart';
import 'package:untitled3/ui/screens/sign-up_screen.dart';
import 'package:untitled3/ui/utils/app_Colors.dart';
import 'package:untitled3/ui/utils/page_transition.dart';
import 'package:untitled3/ui/utils/spinkit.dart';
import 'package:untitled3/ui/utils/toastMessage.dart';



class signInScreen extends StatefulWidget {
  const signInScreen({super.key});

  @override
  State<signInScreen> createState() => _signInScreenState();
}

class _signInScreenState extends State<signInScreen> {
  final TextEditingController _newEmailController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final signInController controller = Get.find<signInController>();

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
                Text('Get started with',
                    style: textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.themeColor)),
                SizedBox(
                  height: 24,
                ),
                _buildSignInForm(),
                SizedBox(
                  height: 40,
                ),
                Center(
                    child: TextButton(
                  onPressed: _onTapForgetPassButton,
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(color: Colors.black),
                  ),
                )),
                SizedBox(
                  height: 8,
                ),
                _buildRichText()
              ],
            ),
          ),
        ));
  }

  Widget _buildRichText() {
    return Center(
      child: RichText(
          text: TextSpan(
              text: "Don't have an account?",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              children: [
            TextSpan(
                text: " Sign Up",
                style: TextStyle(
                    color: AppColors.themeColor, fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()..onTap = _onTapSignUpButton)
          ])),
    );
  }

  Widget _buildSignInForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _newEmailController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a valid email address';
              }
              return null;
            },
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
            controller: _newPassController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must contain a minimum of 6 characters';
              }
              return null;
            },
            cursorColor: AppColors.themeColor,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GetBuilder<signInController>(builder: (controller) {
            return ElevatedButton(
              onPressed: _onTapLoginButton,
              child: !controller.inProgress
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style:
                              TextStyle(color: Color(0xFFFEFFF1), fontSize: 18),
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
                  : Center(child: spinKit.normalLoader()),
            );
          }
          ),
        ],
      ),
    );
  }

  Future<void> _signIn() async {
    final bool result = await controller.signIn(
        _newEmailController.text.trim(),
        _newPassController.text
    );

    if (result) {
      Get.offAllNamed('/home');
    }
  }

  void _onTapLoginButton() {
    if (_formKey.currentState!.validate()) {
      _signIn();
    }
  }

  void _onTapForgetPassButton() {
    Get.to(()=> ForgotPassScreen(),transition: Transition.leftToRightWithFade);
  }

  void _onTapSignUpButton() {
    Get.to(()=> signUpScreen(),transition: Transition.leftToRightWithFade);
  }

  @override
  void dispose() {
    _newEmailController.dispose();
    _newPassController.dispose();
    super.dispose();
  }
}
