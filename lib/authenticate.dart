import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Authenticate {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User?> sigUp(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
          

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully sign up")));
   
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
     
    }
  }

 signIn(String emails, String passwords, BuildContext context) async {
  String success = "success";
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: emails, password: passwords);
      // print(userCredential);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully login")));

      return success;

 
    
    } catch (e) {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
     return null;

   
    }
  }

  signOut(BuildContext context) async {
    try {
       await firebaseAuth.signOut();

         Navigator.pushNamed(context, "/");
                          
         
     
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
       
      
    }
   
  }
}
