import 'package:blogapp/authenticate.dart';
import 'package:blogapp/home.dart';
import 'package:blogapp/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MySignUp extends StatefulWidget {
  const MySignUp({super.key});

  @override
  State<MySignUp> createState() => _MySignUpState();
}

class _MySignUpState extends State<MySignUp> {
  Authenticate authenticate = Authenticate();
  final _formkey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("The blog app"),
        centerTitle: true,
      ),
      body: Container(
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
                Flexible(
                  child: TextFormField(
                    validator: (value) {
                      _email = value.toString();
                      if (_email.isEmpty) {
                        return "add something in email field";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "email",
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.00,
                ),
                Flexible(
                  child: TextFormField(
                    validator: (value) {
                      _password = value.toString();
                      if (_password.isEmpty) {
                        return "add password";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "password",
                    ),
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
                    }
                  },
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
    );
  }
}
