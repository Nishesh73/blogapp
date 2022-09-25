
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class MyPhotoUpload extends StatefulWidget {
  const MyPhotoUpload({super.key});

  @override
  State<MyPhotoUpload> createState() => _MyPhotoUploadState();
}

class _MyPhotoUploadState extends State<MyPhotoUpload> {
  String values="";
  String url="";
  final _formkey=new GlobalKey<FormState>();

   File? sampleImage;

  


  bool validateAndSave(){

    return _formkey.currentState!.validate();

      
    }

    void uploadStatusImage() async{
      if(validateAndSave()){
        
        Reference storageReference=FirebaseStorage.instance.ref().child("imagefolder");
        
        var timekey=DateTime.now();
        UploadTask uploadTask=storageReference.child(timekey.toString()+".jpg").putFile(sampleImage!);


        //milya xaina

       // var imageurl=await uploadTask.then((val) =>val.ref.getDownloadURL());
        var imageurl=await (await uploadTask).ref.getDownloadURL();
        url=imageurl.toString();
       // print(url);

        

        saveToDatabase(url);
        gotoHomePage();
        

}     

 }


  void saveToDatabase(imageurl) async{

          var dbkey=DateTime.now();

          var dateformat=DateFormat("MMM d, yyyy");
          var timeformat=DateFormat("EEEE, hh:mm aaa");

          String date=dateformat.format(dbkey);
          String time=timeformat.format(dbkey);


          

          var data={
            "image":url,
            "description":values,
            //"url":url,
            "time":time,
            "date":date,
};

          CollectionReference collectionReference=FirebaseFirestore.instance.collection("posts");
          await collectionReference.add(data);



        }

  void gotoHomePage(){

    Navigator.pushNamed(context, "/homes");



  }    



  Future<void> getImages() async{

    //ImagePicker imagePicker=new ImagePicker(); inorder access from gallery
    //var tempimage=await imagePicker.pickImage(source: ImageSource.gallery);
    //var tempfile=File(tempimage!.path);

    FilePickerResult tempfile=await FilePicker.platform.pickFiles(type: FileType.custom) as FilePickerResult;

    //tempimage tye is xfile
    //below tempimage type change to file

   

   setState(() {
      sampleImage=tempfile as File?;
    });



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("upload image"),
      
      centerTitle: true,),

      body: Center(
        child: sampleImage==null?Text("select the image"):enableUpload(),
      ),

      floatingActionButton: FloatingActionButton(onPressed: getImages,
      
      child: Icon(Icons.add_a_photo),),

      
    );
  }

  Widget enableUpload(){

    return SingleChildScrollView(
      child: Container(
    
        height: 700,
        width: 500,
        child: Form(
          key: _formkey,
          
          child: Column(children: [
    
          Image.file(sampleImage!,width: 300,height: 300,),
        //  Image.asset("$sampleImage",width: 300,height: 300,),
        
    
            SizedBox(height: 5.00,),
            TextFormField(
            
              decoration: InputDecoration(labelText: "description"),
            
              validator: (value) {
            
                return value!.isEmpty?"please add description":null;
                
              },
            
              onChanged: ((value) {
            
                setState(() {
                  values=value;
                  
                });
                
              }),
            ),
    
            ElevatedButton(onPressed: uploadStatusImage, child: Text("postablog")),
    
    
    
    
        ],)
        
        ),
      ),
    );






  }
}