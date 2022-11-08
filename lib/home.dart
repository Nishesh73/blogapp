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

  String? date, description, image, time;

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
            stream: FirebaseFirestore.instance.collection("posts").snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshots) {
              if (!snapshots.hasData) {
                return LinearProgressIndicator();
              }

              return ListView(
                children: snapshots.data!.docs.map<Widget>((document) {
                  return Container(
                    margin: EdgeInsets.all(15.0),
                    child: Card(
                      elevation: 10.0,
                      shadowColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                document["date"],
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                document["time"],
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Image.network(document["image"]),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(document["description"]),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/photoup");
                  },
                  icon: Icon(Icons.add_a_photo)),
            ],
          ),
        ));
  }
}
