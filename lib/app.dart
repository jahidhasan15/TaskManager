import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmgpjme/ui/screen/forgot_newpassword_screen.dart';
import 'package:tmgpjme/ui/screen/main_buttom_nav_screen.dart';
import 'package:tmgpjme/ui/screen/splash_screen.dart';
import 'package:tmgpjme/ui/utills/app_color.dart';

class TaskManagerMP extends StatefulWidget {
  const TaskManagerMP({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManagerMP> createState() => _TaskManagerMPState();
}

class _TaskManagerMPState extends State<TaskManagerMP> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManagerMP.navigatorKey,
      theme: ThemeData(
        colorSchemeSeed: AppColor.themeColor,
        textTheme: _textTheme(),
        elevatedButtonTheme: _elevatedButtonThemeData(),
        inputDecorationTheme: _inputDecorationTheme(),
      ),
      initialRoute: '/',
      routes: {
        SplashScreen.name :(context) => const SplashScreen(),
        MainButtomNavScreen.name:(context)=> const MainButtomNavScreen(),
      },
    );
  }
}

TextTheme _textTheme() {
  return const TextTheme(
    titleSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    displayMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
    displayLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );
}

ElevatedButtonThemeData _elevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColor.themeColor,
      foregroundColor: Colors.white,
      fixedSize: const Size.fromWidth(double.maxFinite),
      padding: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

InputDecorationTheme _inputDecorationTheme() {
  return InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    hintStyle: const TextStyle(
      color: Colors.grey,
    ),
    border: _inputBorder(),
    enabledBorder: _inputBorder(),
    focusedBorder: _inputBorder(),
    errorBorder: _inputBorder(),
    disabledBorder: _inputBorder(),
  );
}

OutlineInputBorder _inputBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(8),
  );
}
