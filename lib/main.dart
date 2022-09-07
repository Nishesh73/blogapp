import 'package:blogapp/login.dart';
import 'package:flutter/material.dart';


void main(){

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

      home: MyLogin(),

      



    );
  }
}