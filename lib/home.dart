
import 'package:blogapp/homepost.dart';
import 'package:blogapp/settings.dart';
import 'package:blogapp/upload.dart';
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int index = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//       appBar: AppBar(
//         title: Text("Home"),//app bar is not share across all page that's why
//donot provide appbar each page have its own appbar
// ),

body: PageView(
  controller: pageController,
  children: [
    // MyHome(),donot nest MyHome inside MyHome it will give error
    HomePost(),
    Upload(),
    Settings(),


],),
bottomNavigationBar: BottomNavigationBar(
  type: BottomNavigationBarType.fixed,
  currentIndex: index ,//parameter for currently selected item
//onTap function fire when bootomitem tap
  onTap: ((value) {
    setState(() {
     index = value;
    });
    //here PageView controlled by pageController  when bootomItem get selected pagController
    //will navigate to page given by value(index ) of page in 2 sec, using animation
    pageController.animateToPage(value, duration: Duration(seconds: 1), curve: Curves.easeIn);
    //here PageView widget react on the basis of pageViewcontroller although we
    //donot rebuild ui, when the indexvalue or pageindex changed by pageContoller the PageView
    //widget rebuild itself we don't need build ui by using setstate
    
  }),
  
  items:[
  BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
    BottomNavigationBarItem(icon: Icon(Icons.upload), label: "upload"),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: "settings"),

])

// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  
//   children: [

//   IconButton(onPressed: (){}, icon: Icon(Icons.ad_units)),
//   IconButton(onPressed: (){}, icon: Icon(Icons.upload)),
//   IconButton(onPressed: (){}, icon: Icon(Icons.settings)),
  

// ],)
,);
    

    
  }
}


