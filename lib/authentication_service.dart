import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'StudentLogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);
  

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  void signIn({required String email,required String password,context}) async {
    // var checkauth = await FirebaseFirestore.instance.collection('authuser').doc(email).get();  
    //  if(checkauth.exists){
       print("ungere");
    var checkauth = await FirebaseFirestore.instance.collection('authuser').doc(email).get();  
     if(checkauth.exists){
   try { 


    print("ungere");
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

                Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => StudentLogin(
                                scourse: email
                                
                                    // .split("@")
                                    // .join()
                                    // .split(".in")
                                    // .join()
                                    )));
                            //  Navigator.of(context).push(MaterialPageRoute(
                            // builder: (context) => AuthenticationWrapper(
                            //     req: email
                                
                            //         // .split("@")
                            //         // .join()
                            //         // .split(".in")
                            //         // .join()
                            //         )));         
                              
                                   
       return showDialog(context: context, builder: (context){return AlertDialog(title: Text("Succesfully logged in"),);});
          
           }
          
                

 
       
     on FirebaseAuthException catch (e) {
      return showDialog(context: context, builder: (context){return AlertDialog(title: Text("Invalid Password or Email"),content: Text(e.toString()),);});
    }
  }else{      return showDialog(context: context, builder: (context){return AlertDialog(title: Text("Please be patient"),content: Text("Your account might not be activated yet or you might not have registered"),);});
}
  }
  /// There are a lot of different ways on how you can do exception handling.  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
void signUp({required String email,required String password,context}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return showDialog(context: context, builder: (context){return AlertDialog(title: Text("Succesfully logged in"),);});
    } on FirebaseAuthException catch (e) {
      return showDialog(context: context, builder: (context){return AlertDialog(title: Text("Error"),content: Text(e.toString()),);});
    }
  }
}