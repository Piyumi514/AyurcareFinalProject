import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
final _auth = FirebaseAuth.instance;

  get email => null;

  Future<User?> createUserWithEmailAndPassword(
    String username,String password)async{
      try{
    // ignore: non_constant_identifier_names
    final Cred = await _auth.createUserWithEmailAndPassword(
      email: email , password: password);
 return Cred.user;
 }catch(e){
  log("Something went wrong" as num);
 }
 return null;
  } 

Future<User?> loginUserWithEmailAndPassword(
    String username,String password)async{
      try{
    // ignore: non_constant_identifier_names
    final Cred = await _auth.signInWithEmailAndPassword(
      email: email , password: password);
 return Cred.user;
 }catch(e){
  log("Something went wrong" as num);
 }
 return null;
  } 

Future<void> signout() async{
  try{
    await _auth.signOut();
  }catch(e){
     log("Something went wrong" as num);
  }
}
} 