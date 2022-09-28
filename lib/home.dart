
//import 'dart:html';


//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int? documentlength;
  

  String? date, description,image,time;
  

  @override
  void initState() { 
    super.initState();
   
}


 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
),

body: StreamBuilder(

  stream:FirebaseFirestore.instance.collection("posts").snapshots(),
  builder:(BuildContext context,AsyncSnapshot snapshots){
    if(!snapshots.hasData){
      return LinearProgressIndicator();
    }

    return ListView(
      children: snapshots.data!.docs.map<Widget>((document){

        return Column(children: [
          Row(children: [
            
           Text(document["date"]),

             SizedBox(width:10.0),

           Text(document["time"]),



          ],),

          Image.network(document["image"]),
                  SizedBox(height: 10.0,),
          Text(document["description"]),

          SizedBox(height: 10,)






        ],);

        

        


        



      }).toList(),
       

      

       
       );


  } ),

bottomNavigationBar: BottomAppBar(child: 

Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  
  children: [

  IconButton(onPressed: (){}, icon: Icon(Icons.ad_units)),

  
  IconButton(onPressed: (){

   Navigator.pushNamed(context, "/photoup");


  }, icon: Icon(Icons.add_a_photo)),
  

],)
,)



    

    );
  }

  


 
}

 