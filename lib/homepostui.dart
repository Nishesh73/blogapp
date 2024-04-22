import 'package:flutter/material.dart';
class HomeUi extends StatelessWidget {
  String imageUrl, email;
  Function() callback;
  HomeUi({super.key, required this.imageUrl, required this.email, required this.callback});

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
              border: Border.all(color: Colors.grey)
              
            ),
            height: 400,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(imageUrl, fit: BoxFit.fill,),
            ),
            //crop may cut the photo but fill not
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(email, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                color: Colors.grey
                ),),
              )),
              //i will press this button when i interact in ui
              IconButton(onPressed: (){
                callback();//called when iconbutton press
                //callback - reference to the function variable i.e it points function variable
                //only without doing anything
              }, icon: Icon(Icons.delete))
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}