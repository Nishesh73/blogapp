
import 'package:blogapp/home.dart';
import 'package:blogapp/login.dart';
import 'package:blogapp/provider/themenotifier.dart';
import 'package:blogapp/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// flutter run -d edge --web-renderer html
// Import the generated file
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider<ThemeNotifier>(
      create: (context) {
        return ThemeNotifier();
      },
      child: BlogApp()));
}

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "blog app",
      theme: Provider.of<ThemeNotifier>(context).getTheme(),

      debugShowCheckedModeBanner: false,

      //home: MySignUp();

      // initialRoute:"/",no need of this

      routes: {
        "/": (context) => StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, asyncSnap) {
              if (asyncSnap.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (asyncSnap.data != null || asyncSnap.hasData) {
                return MyHome();
              }

              return MySignUp();
            }),
        // MySignUp(),
        "/homes": (context) => MyHome(),
        "/signup": (context) => MySignUp(),
       
      },
    );
  }
}
