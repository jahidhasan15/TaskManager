import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmgpjme/ui/controllers/forgot_email_controller.dart';
import 'package:tmgpjme/ui/screen/forgot_otp_screen.dart';
import 'package:tmgpjme/ui/screen/sign_in_screen.dart';
import 'package:tmgpjme/ui/widget/centered_circular_progress_indicator.dart';
import 'package:tmgpjme/ui/widget/screen_background.dart';
import 'package:tmgpjme/ui/widget/showsnackber_massage.dart';

class ForgotEmailScreen extends StatefulWidget {
  const ForgotEmailScreen({super.key});

  @override
  State<ForgotEmailScreen> createState() => _ForgotEmailScreenState();
}

class _ForgotEmailScreenState extends State<ForgotEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ForgotEmailController _forgotEmailController =
      Get.find<ForgotEmailController>();

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
                    'Your Email Address',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'A 6 digit verification pin send to the email address.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _emailTEController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter the value';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 17),
                  GetBuilder<ForgotEmailController>(
                    builder: (forgotEMController) {
                      return Visibility(
                        visible: !forgotEMController.inProgress,
                        replacement: const CanteredCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: _onTapEmailVerify,
                          child: const Icon(Icons.arrow_forward_ios_sharp),
                        ),
                      );
                    }
                  ),
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

  void _onTapEmailVerify() {
    if (_formKey.currentState!.validate()) {
      _getVerifyEmail(_emailTEController.text.trim());
    }
  }

  Future<void> _getVerifyEmail(String email) async {
    final result = await _forgotEmailController.getVerifyEmail(email);
    if (result) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ForgotOtpScreen(
                    email: email,
                  )));
    } else {
      showSnackBerMassage(context, _forgotEmailController.errorMassage!, true);
    }
  }

  void _onTapSignIn() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }
}
