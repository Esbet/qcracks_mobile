import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../menu/menu_bottom_page.dart';
import '../utils/notifications_service.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  AuthProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  User? get user => _user;

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      UserCredential userCredential =
          await _auth.signInWithProvider(googleProvider);
      User? user = userCredential.user;


      if (user != null) {
        // Check if the user's email domain is allowed
        final String email = user.email!;
        final String domain = email.split('@').last;
        if (domain == 'quind.io') {
          Navigator.pushReplacementNamed(
              // ignore: use_build_context_synchronously
              context,
              MenuBottomPage.routeName);

            // String? bearer = await FirebaseAuth.instance.currentUser!.getIdToken();
            // log(bearer!);
        } else {
          await _auth.signOut();

          NotificationsService.showSnackBar(
              title: "hola", message: "No tienes acceso para ingresar.");
        }
      }
    } catch (error) {
      log(error.toString());

      NotificationsService.showSnackBar(
          title: "hola", message: "Error de autenticación.");
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }
}
