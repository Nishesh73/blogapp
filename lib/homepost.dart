import 'package:blogapp/homepostui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class HomePost extends StatefulWidget {
  const HomePost({super.key});

  @override
  State<HomePost> createState() => _HomePostState();
}

class _HomePostState extends State<HomePost> {
  //gradle inside app directory called---app level gradle
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection("posts")
      .doc(FirebaseAuth.instance.currentUser?.uid).collection("postItem").snapshots(),
       builder: (context, asyncsnapshot){
        if(asyncsnapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());

        } 
        if(asyncsnapshot.data==null || !asyncsnapshot.hasData){
          return Text("No data available");

        }
       

        return ListView.builder(
          shrinkWrap: true,
          itemCount: asyncsnapshot.data?.docs.length,
          itemBuilder: (context,index){
          return HomeUi(imageUrl: asyncsnapshot.data?.docs[index].get("url")??"",
          //if url:"null" to handle this ??""
          email: asyncsnapshot.data?.docs[index].get("email")??"" ,
          //below function will execute when i press the button
          callback: (() {
            print("function as parameter");
            
            
          }),
          
          );
        });

       }),
    );
  }
}