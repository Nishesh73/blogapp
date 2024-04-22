import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  logOut()async{
    try {
     await FirebaseAuth.instance.signOut();
      Navigator.pushNamed(context, "/signup");
      
    } catch (e) {
      
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Settings"),
        centerTitle: true,
      actions: [IconButton(onPressed: (){
        logOut();
      }, icon: Icon(Icons.logout))],
      
      ),
      body: Column(
        children: [
          Container(
          
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade200,),
            
            
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dark Mode", style: TextStyle(fontSize: 20),),
                  Switch(value: false, onChanged: (_){}),
                ],
              ),
            ),),
Divider(),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: [
                  CircleAvatar
                (child: Icon(Icons.person)),
                Text(FirebaseAuth.instance.currentUser?.email.toString()??"no user name"),
              ],),
            )
        ],
      ),
    );
  }
}