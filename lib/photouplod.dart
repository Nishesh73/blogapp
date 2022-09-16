import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyPhotoUpload extends StatefulWidget {
  const MyPhotoUpload({super.key});

  @override
  State<MyPhotoUpload> createState() => _MyPhotoUploadState();
}

class _MyPhotoUploadState extends State<MyPhotoUpload> {
  String values="";
  final _formkey=new GlobalKey<FormState>();

  late File sampleImage;


  bool validateAndSave(){

    return _formkey.currentState!.validate();

      
    


    





  }


  Future getImages() async{

    ImagePicker imagePicker=new ImagePicker();

    

     dynamic tempimage=await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage=tempimage;
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

    return Container(
    
    
    child: Form(
      key: _formkey,
      
      child: Column(children: [

        Image.file(sampleImage,width: 100,height: 200,),

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

        ElevatedButton(onPressed: validateAndSave, child: Text("postablog")),




    ],))
    
    
    );






  }
}