import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelancer2capitalist/pages/login_page.dart';
import 'package:freelancer2capitalist/pages_old/complete_profile.dart';

import '../models/user_model.dart';
import 'edit_profile.dart';

class VerifyEmail extends StatefulWidget {
  final UserModel newUser;
  final User credential;
  const VerifyEmail(
      {super.key, required this.newUser, required this.credential});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final auth = FirebaseAuth.instance;
  User? user;
  Timer? timer;

  @override
  void initState() {
    user = auth.currentUser;
    user?.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 25), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:
              Text('An Email has been sent to ${user?.email} please verify.')),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user?.reload();
    if (user!.emailVerified) {
      timer?.cancel();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => CompleteProfile(
                userModel: widget.newUser,
                firebaseUser: widget.credential,
              )));
    }
  }
}
