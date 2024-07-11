import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


import '../../../core/theme/colors.dart';
import '../../core/routes/resource_icons.dart';
import '../../microfronts/auth/pages/login_page.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const routeName = "/splash";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    processScreen();

  }


  Future<void> processScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    navigation();
  }

  void navigation() {
    Navigator.pushNamed(context, LoginPage.routeName);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container(color: whiteColor, child: _mainScreen())),
    );
  }

  Widget _mainScreen() {
    return Stack(
      children: [
        _titleScreen(),
      ],
    );
  }

  Widget _titleScreen() {
    return Align(
      alignment: Alignment.center,
      child: Image(
        image: const AssetImage(quindImage),
        fit: BoxFit.cover,
        height: 15.h,
      ),
    );
  }
}