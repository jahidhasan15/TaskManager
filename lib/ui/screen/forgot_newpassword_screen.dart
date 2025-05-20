import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmgpjme/ui/controllers/forgot_new_password_controller.dart';
import 'package:tmgpjme/ui/screen/main_buttom_nav_screen.dart';
import 'package:tmgpjme/ui/screen/sign_in_screen.dart';
import 'package:tmgpjme/ui/widget/centered_circular_progress_indicator.dart';
import 'package:tmgpjme/ui/widget/screen_background.dart';
import 'package:tmgpjme/ui/widget/showsnackber_massage.dart';

class ForgotNewPasswordScreen extends StatefulWidget {
  static const String name = '/forgotNewPasswordScreen';
  final String email;
  final String otp;

  const ForgotNewPasswordScreen(
      {super.key, required this.email, required this.otp});

  @override
  State<ForgotNewPasswordScreen> createState() =>
      _ForgotNewPasswordScreenState();
}

class _ForgotNewPasswordScreenState extends State<ForgotNewPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ForgotNewPasswordController _forgotNewPasswordController =
      Get.find<ForgotNewPasswordController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScreenBackgournd(
        screenSize: screenSize,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 85),
                  Text(
                    'Set Password',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Minimum length Password 6 characters with letters and number',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordTEController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the valid password';
                      }
                      if (value.length <= 6) {
                        return 'Enter the 6 digit password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _confirmPasswordTEController,
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                    validator: (String? value) {
                      if (value != _passwordTEController.text) {
                        return 'Do Not Match Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 17),
                  GetBuilder<ForgotNewPasswordController>(
                      builder: (forgotNWPasswordController) {
                    return Visibility(
                      visible: !forgotNWPasswordController.inProgress,
                      replacement: const CanteredCircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: _onTapMainScreen,
                        child: const Icon(Icons.arrow_forward_ios_sharp),
                      ),
                    );
                  }),
                  const SizedBox(height: 17),
                  Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        Column(
                          children: [
                            _buildSignUpScetion(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpScetion() {
    return RichText(
      text: TextSpan(
        text: "Have an account? ",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: 'Sign In',
            recognizer: TapGestureRecognizer()..onTap = _onTapSignIn,
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  void _onTapMainScreen() {
    if (_formKey.currentState!.validate()) {
      _setNewPassword();
    }
  }

  Future<void> _setNewPassword() async {
    Map<String, dynamic> requestBody = {
      "email": widget.email,
      "OTP": widget.otp,
      "password": _passwordTEController.text,
    };
    final result =
        await _forgotNewPasswordController.setNewPassword(requestBody);
    if (result) {
      _clearTextFiled();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainButtomNavScreen()),
          (p) => false);
    } else {
      showSnackBerMassage(
          context, _forgotNewPasswordController.errorMassage!, true);
    }
  }

  void _onTapSignIn() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }

  void _clearTextFiled() {
    _passwordTEController.clear();
    _confirmPasswordTEController.clear();
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
