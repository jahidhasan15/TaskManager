import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmgpjme/ui/utills/assets_path.dart';

class ScreenBackgournd extends StatelessWidget {
  const ScreenBackgournd({
    super.key,
    required this.screenSize,
    required this.child,
  });

  final Size screenSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AssetsPath.background,
          fit: BoxFit.cover,
          height: screenSize.height,
          width: screenSize.width,
        ),
        SafeArea(child: child),
      ],
    );
  }
}