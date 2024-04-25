import 'dart:typed_data';

import 'package:blogapp/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  Uint8List? uint8list;
  TextEditingController desController = TextEditingController();

  postImageToFirestore() async {
    // we don't have to pass the uintlist parameter inside this function since
    //it is accessibl without doing it, outside this class or file we cant access
    //thus in that scenario we have to pass uin8list as parameter
    // if the widget is disposded before asynchronous task is completes,
    //  calling setstate method will result  an error.
    //to fix this
    if (!mounted) return;
    //mounted -- mount everst ma chadne, means widget not dispose till now
    //in most of the case when i move from one particular screen 1 to 2 at that
    // time dispose method called but when we use bottomnavigation view , tabbarview
    //in that case dispose method is not called until entire widget tree is disposed
    // entire tree is disposed when we close the app only

    if (uint8list == null) {
      return;
    }
    var uuid = Uuid();
    var postId = uuid.v4(); //randomly generate id

    //first store in firebasstorage
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference reference =
        firebaseStorage.ref().child("postFolder").child(postId); //image name
    //reference to the location where image is located
    //uploading the image(asynchronous event)
    await reference.putData(uint8list!);
    //download the image
    String url = await reference.getDownloadURL();
    print("url is $url");
//storing in firestore/ each post will store in user own uid, easy to manage
//since process is aysnchronous it will take time to fetch user authetnication data,
// to ensure every authenticated data will fetch correctily
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("postItem")
          .doc(postId)
          .set({
        "email": currentUser.email,
        "userId": currentUser.uid,
        "postId": postId,
        "description": desController.text,
        "url": url,
      });
    } else {
      dialogBox(context, "current user value is null");
    }
    setState(() {
      uint8list = null;
    });
  }

//steps(3) very imp
  pickImg() async {
    if (!mounted) return;

    //first image will pick
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    //to display in browser we need uint8list image xfile throws an error

    uint8list = await xFile?.readAsBytes();

    setState(() {});

    //image will store in firebasestorage
    //   FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    // Reference reference =  firebaseStorage.ref().child("imagefolder").child("photopath");
    //reference for photo location
    // reference.putFile(filename);//uploading file
    //downloading
    // var data = await  reference.getDownloadURL();

    //reference is required to upload and download data process

    //image will download then store in cloud firestore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: uint8list == null
            ? Center(
                child: IconButton(
                    onPressed: () {
                      pickImg();
                    },
                    icon: Icon(
                      Icons.upload_outlined,
                      size: 80,
                    )))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // height: 40,
                        height: 500,
                        width: double.maxFinite,
                        child: Image.memory(
                          uint8list!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: desController,
                        decoration: InputDecoration(
                            hintText: "describe",
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      postImageToFirestore();

                      setState(() {
                        uint8list = null;
                      });
                    },
                    color: Colors.grey.shade200,
                    child: Text("Post"),
                  ),
                ],
              ));
  }
}
//confuse beside,back meaning pachadi, donot confuse with before and after
