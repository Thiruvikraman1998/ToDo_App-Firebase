import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/utils/snackbar.dart';

//import '../utils/otp_dialog.dart';

class FirebaseServices {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firebaseFirestore;
  FirebaseServices(this._auth, this._firebaseFirestore);

  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  Future<void> signUpWithEmail(
      {required userName,
      required email,
      required password,
      required phoneNumber,
      required context}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // await phoneVerification(context, phoneNumber);
      await _auth.currentUser!.updateDisplayName(userName);
      print(_auth.currentUser!.displayName);
      await sendEmailVerification(context);
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
      if (_auth.currentUser != null && _auth.currentUser!.emailVerified) {
        Navigator.popAndPushNamed(context, '/home');
      } else if (_auth.currentUser == null) {
        showSnackBar(context, 'User not registered');
      } else if (!_auth.currentUser!.emailVerified) {
        await _auth.currentUser!.sendEmailVerification();
        showSnackBar(
            context, "Email not yet verified, verify email and try again");
      }
      print(_auth.currentUser!.email);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      print(e.message);
    }
  }

  // context inside the methods are used to get the buildcontext and dsiplay a snackbor or dialog or any others.
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, "An email has been sent to your register mail id");
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  Future<void> signout(context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}

//   Future<void> phoneVerification(context, String phoneNumber) async {
//     TextEditingController codeController = TextEditingController();
//     await _auth.verifyPhoneNumber(
//       verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
//         await _auth.currentUser!.updatePhoneNumber(phoneAuthCredential);
//       },
//       verificationFailed: (e) {
//         showSnackBar(context, e.message!);
//       },
//       codeSent: ((String verificationId, int? resendToken) async {
//         showOtpDialog(
//           context: context,
//           codeController: codeController,
//           onPressed: () async {
//             PhoneAuthCredential credential = PhoneAuthProvider.credential(
//                 verificationId: verificationId, smsCode: codeController.text);
//             await _auth.currentUser!.updatePhoneNumber(credential);
//           },
//         );
//       }),
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   }

