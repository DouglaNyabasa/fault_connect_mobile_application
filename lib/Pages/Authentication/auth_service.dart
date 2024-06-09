import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  Future signOut() async{
    try{
      await firebaseAuth.signOut();
    }catch(e){
      return null;
    }
  }
}