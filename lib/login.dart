
import 'package:blogapp/authenticate.dart';
import 'package:blogapp/signup.dart';
import 'package:flutter/material.dart';


class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  Authenticate authenticate=Authenticate();

 

  final _formkey=GlobalKey<FormState>();
  String _email="";
  String _password="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("The blog app"),
        centerTitle: true,
        

        
      ),

      body: SingleChildScrollView(
        child: Container(
        
          margin: EdgeInsets.all(15.0),
        
          child: Form(
            key: _formkey,
            child: 
        
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
             mainAxisSize: MainAxisSize.min,
            
            children: [
            
          
            CircleAvatar(
          
              child: Image.asset("lib/image/blog.png",width: 80.00,height: 80.00,),
          
              
          
          
          
            ),
          
            SizedBox(height: 15,),
            TextFormField(
              validator: (value){
          
                setState(() {
                  _email=value.toString();
                  
                });
            
                
                if(_email.isEmpty){
            
                  return "add something in email field";
                }
            
            
              },
             
            
            
            
            
            
              
              decoration: InputDecoration(
                hintText: "email",
            
            
              ),
            ),
          
            SizedBox(height: 10.00,),
            TextFormField(
            
              validator: (value){
                setState(() {
                  _password=value.toString();
                });
            
                
                if(_password.isEmpty){
            
                  return "add password";
                }
              },
            
              decoration: InputDecoration(
                hintText: "password",
            
                
            
            
              ),
            
            
            ),
          
            SizedBox(height: 10,),
            ElevatedButton(onPressed: () async{
          
              if(_formkey.currentState!.validate()){
          
               dynamic val= await authenticate.signIn(_email, _password);
          
               if(val==null){
          
                
          
                print("error ocur");
               }
               else{
          
                print("login successful");
                Navigator.pushNamed(context, "/homes");
          
               }
          
                
          
          
          
              }
          
          
          
            }, child: Text("log in")),
          
          
            TextButton(onPressed: (){
          
             
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MySignUp()));
          
          
          
          
              
          
          
          
          
          
            }, child:Text("not have an account?, create account") ),
            
          
          
          
          ],)
          
          ),
        ),
      ),

      

      


      
    );
  }
}