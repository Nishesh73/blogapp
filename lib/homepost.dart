import 'package:blogapp/homepostui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePost extends StatefulWidget {
  const HomePost({super.key});
  //signature of function-- unique identifier of function like funcion name,
  // return type, parameter etc

  @override
  State<HomePost> createState() => _HomePostState();
}

class _HomePostState extends State<HomePost> {
//  String? postId;//culprit is this, to maintain the delete like comment feature in specific
//post without disturbing other post we must declare postId locally
 var likes;
 bool isLIked = false;

  
  //gradle inside app directory called is called app level gradle
  //  late QuerySnapshot querySnap; querySnap should be assign some value before accessign it
  //since operation is async it may take time to completes, if we try to access it before
  //assigning it will give late initialization error,
  // QuerySnapshot? querySnap;//initially when the data not assign basically it is null
  // List<QuerySnapshot> querySnapList = [];
  //  QuerySnapshot? querySnapshot ;
  // //fetching all post
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   fetchAllPost();
  // }

  // fetchAllPost() async {
  //   if (!mounted) return;
    //mounted - mount everest ma chadne, means (dispose navayeko)
    // List<QuerySnapshot> tquerySnapList = [];

//     try {
//          querySnapshot =
//         await FirebaseFirestore.instance.collection("posts").get();

//     //iterate from list of document
    
//     // for (var mydoc in querySnapshot.docs) {
//       //to get all documents from querySnapshot, use querySnapshot.docs==all documents
//       //now we have each document to get id just do mydoc.id
//       //if you are doing like this in every iteration you will get data store in
//       //querysnap but last data will be overwrite by latest one means at the end
//       //of iteration querySnap will contain latest data only not all data
//       // QuerySnapshot? querySnap = await FirebaseFirestore.instance
//       //     .collection("posts")
//       //     .doc(mydoc.id)
//       //     .collection("postItem")
//       //     .get();
//       // if (querySnap != null) {
//       //   //in each iteration we will get the querySnap then we will put inside querySnapList
//       //   tquerySnapList.add(querySnap);
       
        
//       // } else {
//       //   print("no data available");
//       // }
//     // }
// //  setState(() {
// //       querySnapList = tquerySnapList;


// //     });
      
//     } catch (e) {
//       print("error occur $e");
      

//     }
  

   


  // }

  //showing delete dialogbox
   showDeleteDialogBox(String postId){
    showDialog(
      
      barrierDismissible: false,
      context: context, builder: (context){
      return AlertDialog(
        
       shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
       ),
        content: Text("Do you really want to delete the post?"),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("No")),
          TextButton(onPressed: (){
             deletePost(postId);


          }, child: Text("Yes")),
        ],
      );
    });
   }
   //likePost
   likePost(String postId){
// toogle button 
setState(() {
  isLIked = !isLIked;
  
});
//will work because isLIked related to specific postlike
if(isLIked){
    FirebaseFirestore.instance.collection("posts")
    .doc(postId)
    .update({

      "like": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.email])
    });}
    
    else{
      
      FirebaseFirestore.instance.collection("posts")
    .doc(postId)
    .update({

      "like": FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.email])
    });


    }

   }
  //deletepost
  deletePost(String postId)async{

    try {
    await  FirebaseFirestore.instance.collection("posts").doc(postId).delete();
     Navigator.pop(context);
    } catch (e) {
      print("some error occured");
      
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchFirestoreData();
  }
   fetchFirestoreData()async{
  // likes =  await FirebaseFirestore.instance.collection("posts").doc(postId).get();
 
setState(() {
  
});



   }

  //we can directly assign list type to list
  @override
  Widget build(BuildContext context) {

    print("homepost execute");
    // print("querysnapshot is $querySnapList");
    
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("posts").orderBy("timeStamp", descending:true ).snapshots(),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
               return Center(child: CircularProgressIndicator());

            }
            //to check document exist or not
            
            //below code is for checking querysnapshot or documentsnapshot
            if(!snapshot.hasData || snapshot.data==null){
              //snapshot.data = object of query or document snapshot
              //snapshot.hasData acts as a flag(have true or false value) does two task 
              //1. whether asynschrnous task is//completed or not 2. data is available or
              // not(querysnapshot or documentsnapshot)
              //if asynchrnous operation completed and data is available flag value set true
              //and if asynchrnous operation is ongoing or completed but data is not available
              //in that case flag set to false
              //snapshot.data represent querysnapshot or documentsnapshot based on scenario
              //what type of data i am fetching 
              return Center(child: Text("wait for asynchrnous task to complete"));
            }
            //for querysnapshot??true, for documentsnapshot??false
            //to handle particularly document exist or not
            if(snapshot.data?.docs.isEmpty??true){
              //if there is no null value of snapshot.data then docs.isEmpty is execute
              //suppose snapshot.data value is null then true will execute it is nothing
              //but to handle runtime error value for querysnapshot similar case will happen
              //documensnapshot but for that we have to use??false
              return Center(child: Text("There is no any docs to fetch")); 


            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                //we use map() function for list to perform iteration
                itemBuilder: (context, index) {
                String postId = snapshot.data!.docs[index].get("postId");
                  return HomeUi(imageUrl: snapshot.data!.docs[index].get("url"),
                   email: snapshot.data!.docs[index].get("email"),
                   description:snapshot.data!.docs[index].get("description") ,
                   postId: postId,
                   
                   callback: (){
                    showDeleteDialogBox(postId);

                   },
                   likeCallBack: (){
                    likePost(postId);
                   },
                   commentCallBack: (){},
                   
                   
                   );

                  // return Text(snapshot.data?.docs[index].get("email")??"");//if we got
                  //condition where document is present but the map value of one or more
                  //key have value of null eg. "email": null to resolve this
                  //itembuilder property won't call if itemcount is 0 because the main purpose of 
                  //itembuilder is to build each item in list, if itemcount is zero there is nothing
                  // to build thus for itemcount 0, below Text("There is no data"); is also not dis
                  //play
                  // if (querySnapList.isEmpty) {    //gives either true or false value
                  //   return Text("There is no data");
                  // }
                  //get the querysnapshot at the current index
                  // QuerySnapshot querySnapshot = querySnapList[index];
            
                  // return Text(querySnapshot.docs[index].get("postId") ?? "no data");
            
                  // return HomeUi(imageUrl: asyncsnapshot.data?.docs[index].get("url")??"",
                  // //if url:"null" to handle this ??""
                  // email: asyncsnapshot.data?.docs[index].get("email")??"" ,
                  // //below function will execute when i press the button
                  // callback: (() {
                  //   print("function as parameter");
            
                  // }),
            
                  // );
                });
          }
        )
            
            );


  }
}
