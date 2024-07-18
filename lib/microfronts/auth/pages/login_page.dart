import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qcracks_mobile/core/providers/auth_provider.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../../../core/routes/resource_icons.dart';

class LoginPage extends StatelessWidget {
  static const routeName = "/login";

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(loginImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: _googleSignInButton(authProvider, context),
          ),
        ),
      ),
    );
  }

  Widget _googleSignInButton(AuthProvider authProvider, BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButton(
          Buttons.google,
          text: "Sign up with Google",
          onPressed: () {
            authProvider.signInWithGoogle(context);
          },
        ),
      ),
    );
  }
}
