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
  //gradle inside app directory called is called app level gradle
  //  late QuerySnapshot querySnap; querySnap should be assign some value before accessign it
  //since operation is async it may take time to completes, if we try to access it before
  //assigning it will give late initialization error,
  // QuerySnapshot? querySnap;//initially when the data not assign basically it is null
  List<QuerySnapshot> querySnapList = [];

  //fetching all post
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllPost();
  }

  fetchAllPost() async {
    if (!mounted) return;
    //mounted - mount everest ma chadne, means (dispose navayeko)
    List<QuerySnapshot> tquerySnapList = [];

    try {
        QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("posts").get();

    //iterate from list of document
    
    for (var mydoc in querySnapshot.docs) {
      //to get all documents from querySnapshot, use querySnapshot.docs==all documents
      //now we have each document to get id just do mydoc.id
      //if you are doing like this in every iteration you will get data store in
      //querysnap but last data will be overwrite by latest one means at the end
      //of iteration querySnap will contain latest data only not all data
      QuerySnapshot? querySnap = await FirebaseFirestore.instance
          .collection("posts")
          .doc(mydoc.id)
          .collection("postItem")
          .get();
      if (querySnap != null) {
        //in each iteration we will get the querySnap then we will put inside querySnapList
        tquerySnapList.add(querySnap);
       
        
      } else {
        print("no data available");
      }
    }
 setState(() {
      querySnapList = tquerySnapList;


    });
      
    } catch (e) {
      print("error occur $e");
      

    }
  

   


  }

  //we can directly assign list type to list
  @override
  Widget build(BuildContext context) {

    print("homepost execute");
    print("querysnapshot is $querySnapList");
    
    return Scaffold(
        body:querySnapList.isEmpty?
        
        Center(child: Text("There is no data at all")): ListView.builder(
            shrinkWrap: true,
            itemCount: querySnapList.length,
            //we use map() function for list to perform iteration
            itemBuilder: (context, index) {
              //itembuilder property won't call if itemcount is 0 because the main purpose of 
              //itembuilder is to build each item in list, if itemcount is zero there is nothing
              // to build thus for itemcount 0, below Text("There is no data"); is also not dis
              //play
              // if (querySnapList.isEmpty) {    //gives either true or false value
              //   return Text("There is no data");
              // }
              //get the querysnapshot at the current index
              QuerySnapshot querySnapshot = querySnapList[index];

              return Text(querySnapshot.docs[index].get("postId") ?? "no data");

              // return HomeUi(imageUrl: asyncsnapshot.data?.docs[index].get("url")??"",
              // //if url:"null" to handle this ??""
              // email: asyncsnapshot.data?.docs[index].get("email")??"" ,
              // //below function will execute when i press the button
              // callback: (() {
              //   print("function as parameter");

              // }),

              // );
            })
            
            );


  }
}
