

import 'package:firebase_auth/firebase_auth.dart';

class Authenticate{

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;


  Future<String> sigUp(String emails, String passwords) async{

    User user= (await firebaseAuth.createUserWithEmailAndPassword(email: emails, password: passwords)) as User;

    return user.uid;

}

Future<String> signIn(String emails, String passwords) async{
  User user= (await firebaseAuth.signInWithEmailAndPassword(email: emails, password: passwords)) as User;

  return user.uid;


}

Future<String> getCurrentUserId() async{

  User user=(await firebaseAuth.currentUser) as User;
  return user.uid;




}

Future<void> signOut() async{
  await firebaseAuth.signOut();



}




}