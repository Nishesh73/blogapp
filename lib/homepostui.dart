import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeUi extends StatelessWidget {
  String imageUrl, email, description, postId;
 

   Function() callback; //callback is variable, type function
   VoidCallback likeCallBack;
   VoidCallback commentCallBack;
  HomeUi(
      {super.key,
      required this.imageUrl,
      required this.email,
      required this.description,
       required this.callback,
       required this.likeCallBack,
       required this.commentCallBack,
       required this.postId,
       
      
      });
  // VoidCallback--represnt function with no return type and no parameter
  //Function()--is general represent function with return type and parameter, but we have
  //flexibility to whether we want to pass parameter or not that is our choice, similar case
  //for return value as well

  @override
  Widget build(BuildContext context) {
    print("image url is $imageUrl");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                //to give color use border property
                border: Border.all(color: Colors.grey)),
            height: 400,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            //crop may cut the photo but fill not
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                  email,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                                  ),
                                ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(description??"description nor provided"),
                      //suppose description is ""(empty) right side statement wont execute 
                      //mind it
                    ),

                ],
              ),
              Column(
                children: [
                  IconButton(onPressed: (){
                    likeCallBack();
                  }, icon: Icon(Icons.favorite) ),
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance.collection("posts").doc(postId).snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return CircularProgressIndicator();
                      }
                      return Text("${snapshot.data?.get("like").length}");
                    }
                  )
                ],
              ),
              Column(
                children: [
                  IconButton(onPressed: (){
                    commentCallBack();
                  }, icon: Icon(Icons.comment)),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("posts").doc(postId).collection("comment").snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                      }
                      return Text("${snapshot.data?.docs.length}");
                    }
                  ),

                ],
              ),
              //i will press this button when i interact in ui
              IconButton(
                  onPressed: () {
                     callback() ;//called when iconbutton press, it will invoke function
                    //callback - reference to the function variable i.e it points function variable
                    //only without doing anything
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
   
                 
          Divider(),
        ],
      ),
    );
  }
}
