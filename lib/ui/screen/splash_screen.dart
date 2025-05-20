import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmgpjme/ui/controllers/auth_controller.dart';
import 'package:tmgpjme/ui/screen/main_buttom_nav_screen.dart';
import 'package:tmgpjme/ui/screen/sign_in_screen.dart';
import 'package:tmgpjme/ui/utills/assets_path.dart';
import 'package:tmgpjme/ui/widget/screen_background.dart';

class SplashScreen extends StatefulWidget {
  static const String name='/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _nextScreen();
    super.initState();
  }

  Future<void> _nextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (AuthController.inLoggedIn()) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const MainButtomNavScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SignInScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      body: ScreenBackgournd(
        screenSize: screenSize,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AssetsPath.logo),
            ],
          ),
        ),
      ),
    );
  }
}
