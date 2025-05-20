import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tmgpjme/ui/controllers/sing_in_controller.dart';
import 'package:tmgpjme/ui/screen/forgot_email_screen.dart';
import 'package:tmgpjme/ui/screen/main_buttom_nav_screen.dart';
import 'package:tmgpjme/ui/screen/sing_up_screen.dart';
import 'package:tmgpjme/ui/widget/centered_circular_progress_indicator.dart';
import 'package:tmgpjme/ui/widget/screen_background.dart';
import 'package:tmgpjme/ui/widget/showsnackber_massage.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SingInController singInController = Get.find<SingInController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScreenBackgournd(
        screenSize: screenSize,
        child: SingleChildScrollView(
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
                      'Get Started With',
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _emailTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter the value';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _passwordTEController,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter the value';
                        }
                        if (value!.length <= 6) {
                          return 'Enter a 6 c password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    GetBuilder<SingInController>(
                        builder: (controller) {
                      return Visibility(
                        visible: !controller.inProgress,
                        replacement: const CanteredCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: _onTapNextScreen,
                          child: const Icon(Icons.arrow_forward_ios_sharp),
                        ),
                      );
                    },),
                    const SizedBox(height: 15),
                    Center(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        children: [
                          Column(
                            children: [
                              TextButton(
                                onPressed: _onTapForgotPassword,
                                child: const Text(
                                  'Forgot Password ?',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
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
      ),
    );
  }

  Widget _buildSignUpScetion() {
    return RichText(
      text: TextSpan(
        text: "Don't Have account? ",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: 'Sign Up',
            recognizer: TapGestureRecognizer()..onTap = _onTapSignUp,
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  void _onTapSignUp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  void _onTapForgotPassword() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ForgotEmailScreen()));
  }

  void _onTapNextScreen() {
    if (_formKey.currentState!.validate()) {
      _sinIn();
    }
  }

  Future<void> _sinIn() async {
    final bool result = await singInController.sinIn(
      _emailTEController.text.trim(),
      _passwordTEController.text,
    );

    if (result) {
      Get.offAllNamed(MainButtomNavScreen.name);
       // Navigator.pushNamedAndRemoveUntil(context ,MainButtomNavScreen.name, (_)=>false);
    } else {
      showSnackBerMassage(context, singInController.errorMassage!, true);
    }
  }
}
