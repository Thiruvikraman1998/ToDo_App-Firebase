import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/utils/snackbar.dart';

class FirebaseServices {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firebaseFirestore;
  FirebaseServices(this._auth, this._firebaseFirestore);

  Future<void> signUpWithEmail(
      {required userName,
      required email,
      required password,
      required phoneNumber,
      required context}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _auth.currentUser!.updateDisplayName(userName);
      print(_auth.currentUser!.displayName);
      // try {
      //   if (_auth.currentUser != null) {
      //     await _firebaseFirestore
      //         .collection('user')
      //         .doc(email)
      //         .set({'phno': phoneNumber});
      //   }
      // } on FirebaseFirestore catch (e) {
      //   print("Error uploading number");
      // }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  Future<void> loginWithEmail(
      {required email, required password, required context}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (_auth.currentUser != null) {
        Navigator.popAndPushNamed(context, '/home');
      }
      print(_auth.currentUser!.email);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}
