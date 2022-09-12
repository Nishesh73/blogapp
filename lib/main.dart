import 'package:blogapp/home.dart';
import 'package:blogapp/login.dart';
import 'package:blogapp/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


// Import the generated file
import 'firebase_options.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(BlogApp(

    

    
  ));



}

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(primarySwatch: Colors.pink),

      title: "blog app",

      debugShowCheckedModeBanner:false ,

      home: MySignUp(),

      



    );
  }
}