import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample_login/home.dart';
import 'package:sample_login/login.dart';

class Wrapper extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, user) {
        if (user.data == null) {
          return LoginPage(title: 'Sample Login');
        } else {
          return HomePage();
        }
      },
    );
  }
}
