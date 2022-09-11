
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
),


bottomNavigationBar: BottomAppBar(child: 

Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  
  children: [

  IconButton(onPressed: (){}, icon: Icon(Icons.ad_units)),
  IconButton(onPressed: (){}, icon: Icon(Icons.add_a_photo)),
  

],)
,)
    

    );
  }
}


