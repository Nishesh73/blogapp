
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("The blog app"),
        centerTitle: true,
        

        
      ),

      body: Container(

        margin: EdgeInsets.all(15.0),

        child: Form(child: 

        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          
          children: [
          

          CircleAvatar(

            child: Image.asset("lib/image/blog.png",width: 80.00,height: 80.00,),

            



          ),

          SizedBox(height: 15,),
          TextFormField(
            decoration: InputDecoration(
              hintText: "email",


            ),
          ),

          SizedBox(height: 10,),
          TextFormField(
            decoration: InputDecoration(
              hintText: "password",


            ),


          ),

          SizedBox(height: 10,),
          ElevatedButton(onPressed: (){}, child: Text("log in")),


          TextButton(onPressed: (){}, child:Text("not have an account?, create account") ),
          



        ],)
        
        ),
      ),

      

      


      
    );
  }
}