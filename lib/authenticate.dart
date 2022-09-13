

import 'package:firebase_auth/firebase_auth.dart';

class Authenticate{

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;


  Future<User?> sigUp(String email, String password) async{

    

    try{
      UserCredential userCredential=await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

    User? user=userCredential.user;
    return user;

    }catch(e){
      print(e);
    }

   
}

Future<User?> signIn(String emails, String passwords) async{ 

  try{
  UserCredential userCredential= await firebaseAuth.signInWithEmailAndPassword(email: emails, password: passwords);

 
  User? user=userCredential.user;

  return user; 


  }

  catch(e){
    print("error is..");
    print(e);
  }
 


}



Future<void> signOut() async{
  await firebaseAuth.signOut();



}




}