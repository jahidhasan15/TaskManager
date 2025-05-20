import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tmgpjme/data/model/network_response.dart';
import 'package:tmgpjme/data/services/network_caller.dart';
import 'package:tmgpjme/data/utills/urls.dart';
import 'package:tmgpjme/ui/controllers/forgot_otp_controller.dart';
import 'package:tmgpjme/ui/screen/forgot_newpassword_screen.dart';
import 'package:tmgpjme/ui/screen/sign_in_screen.dart';
import 'package:tmgpjme/ui/widget/centered_circular_progress_indicator.dart';
import 'package:tmgpjme/ui/widget/screen_background.dart';
import 'package:tmgpjme/ui/widget/showsnackber_massage.dart';

class ForgotOtpScreen extends StatefulWidget {
  final String email;

  const ForgotOtpScreen({
    super.key,
    required this.email,
  });

  @override
  State<ForgotOtpScreen> createState() => _ForgotOtpScreenState();
}

class _ForgotOtpScreenState extends State<ForgotOtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pinTEController = TextEditingController();

  final ForgotOtpController _forgotOtpController =
      Get.find<ForgotOtpController>();

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
                    'Pin Verification',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'A 6 digit verification pin has been send to your email address.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 15),
                  PinCodeTextField(
                    controller: _pinTEController,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      activeColor: Colors.white,
                      errorBorderColor: Colors.white,
                      selectedColor: Colors.white,
                      selectedFillColor: Colors.white,
                      disabledColor: Colors.white,
                      inactiveColor: Colors.white,
                      inactiveFillColor: Colors.white,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    appContext: context,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter The value';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 17),
                  GetBuilder<ForgotOtpController>(
                    builder: (forgotOtpController) {
                      return Visibility(
                        visible: !forgotOtpController.inProgress,
                        replacement: const CanteredCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: _onTapVerify,
                          child: const Text('Verify'),
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

  Future<void> _onTapVerify() async {
    if (_formKey.currentState!.validate()) {
      return _getVerifyOtp(_pinTEController.text);
    }
  }

  Future<void> _getVerifyOtp(String otp) async {
    final result = await _forgotOtpController.getVerifyOtp(otp, widget.email);
    if (result) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ForgotNewPasswordScreen(
                    email: widget.email,
                    otp: otp,
                  )));
    } else {
      showSnackBerMassage(context, _forgotOtpController.errorMassage!, true);
    }
  }

  void _onTapSignIn() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }
}
