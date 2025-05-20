import 'package:flutter/material.dart';
import 'package:tmgpjme/ui/controllers/auth_controller.dart';
import 'package:tmgpjme/ui/screen/profile_Screen.dart';
import 'package:tmgpjme/ui/screen/sign_in_screen.dart';
import 'package:tmgpjme/ui/utills/app_color.dart';
import 'package:tmgpjme/ui/utills/assets_path.dart';

class TmAppBer extends StatelessWidget implements PreferredSizeWidget {
  const TmAppBer({
    super.key,
    this.isProfileScreenOpen = false,
  });

  final bool isProfileScreenOpen;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.themeColor,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (isProfileScreenOpen) {
                return;
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
            },
            child: const CircleAvatar(
              backgroundImage: AssetImage(AssetsPath.rabbil),
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.userData?.fullName ?? '',
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
                Text(
                  AuthController.userData?.email ?? '',
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignInScreen(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
