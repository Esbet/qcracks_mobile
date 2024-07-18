import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../core/menu/menu_bottom_page.dart';
import '../../core/providers/auth_provider.dart';
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
    await Future.delayed(const Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: processScreen(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _mainScreen();
            } else {
              return Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  final user = authProvider.user;
                  if (user != null) {
                    Future.microtask(() =>
                        Navigator.pushNamed(context, MenuBottomPage.routeName));
                  } else {
                    Future.microtask(() =>
                        Navigator.pushReplacementNamed(context, LoginPage.routeName));
                  }
                  return Container(); // Return an empty container while navigation happens
                },
              );
            }
          },
        ),
      ),
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
