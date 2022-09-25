
import 'package:blogapp/authenticate.dart';
import 'package:blogapp/home.dart';
import 'package:blogapp/login.dart';
import 'package:flutter/material.dart';

class MySignUp extends StatefulWidget {
  const MySignUp({super.key});

  @override
  State<MySignUp> createState() => _MySignUpState();
}

class _MySignUpState extends State<MySignUp> {

  String error="you have some error during signup";
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
            ElevatedButton(
              child: Text("Creat an account"),
              
              onPressed: () async{
          
              if(_formkey.currentState!.validate()){
          
              dynamic val=  await authenticate.sigUp(_email, _password);
          
             // print(_email);
             // print(_password);
          
              if(val==null){
                 print("eror is here");
          
                 setState(() {
                  error="please supply valid email address";
                   
                 });
          
                 
                
          
                 
                 
          
                
              }
              else{
          
                print("signup is successful");
                
          
              
             
               Navigator.pushNamed(context, "/homes");
          
          
              }
          
              }
          
          
          
            }, ),
          
            SizedBox(height: 5,),
            Text(error,style: TextStyle(color: Colors.red),),
          
          
          
          
            TextButton(onPressed: (){
          
             
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyLogin()));
          
          
          
            }, child:Text("Have an account? log in") ),
            
          
          
          
          ],)
          
          ),
        ),
      ),

       );
  }
}