import 'dart:js';

import 'package:blogapp/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authenticate {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  sigUp(String email, String password, BuildContext context) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      //after successful signup
      Navigator.pushNamed(context, "/homes");
    } catch (e) {
      print(e);
      dialogBox(context, e.toString());
    }
  }

  signIn(String emails, String passwords, BuildContext context) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: emails, password: passwords);
//  dialogBox(context, "successfully signin");
      Navigator.pushNamed(context, "/homes");
    } catch (e) {
      print("error is..");
      print(e);
      dialogBox(context, e.toString());
    }
  }

  signOut() async {
    await firebaseAuth.signOut();
  }
}
