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
  String error = "you have some error during signup";
  Authenticate authenticate = Authenticate();
  final _formkey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CircleAvatar(
                    child: Image.asset(
                      "lib/image/blog.png",
                      width: 80.00,
                      height: 80.00,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (value) {
                      setState(() {
                        _email = value.toString();
                      });

                      if (_email.isEmpty) {
                        return "add something in email field";

                       
                      }
                      

                       if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email)){

                        return "provide valid email";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "email",
                    ),
                  ),
                  SizedBox(
                    height: 10.00,
                  ),
                  TextFormField(
                    validator: (value) {
                      setState(() {
                        _password = value.toString();
                      });

                      if (_password.isEmpty) {
                        return "add password";
                      }
                      if(_password.length<=5){
                        return "password should have atleast 6 character";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "password",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    child: Text("Creat an account"),
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                    
                            await authenticate.sigUp(_email, _password, context);

                        // print(_email);
                        // print(_password);

                    

                          Navigator.pushNamed(context, "/homes");
                        
                      }
                      
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyLogin()));
                      },
                      child: Text("Have an account? log in")),
                ],
              )),
        ),
      ),
    );
  }
}
