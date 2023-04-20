
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../auth_page.dart';


final user = FirebaseAuth.instance.currentUser!;
final acct_balance = 0.00;
final hpower = 100;
final passcode = 'default';
final wallet ='';
final userEmail = user.email.toString();
addUserDetails(String userEmail,double acct_balance,int hpower,String passcode,String wallet) async{

  var users = await FirebaseFirestore.instance.collection("user").doc(userEmail);
  users.set(
      {
        'email':userEmail,
        'balance': acct_balance,
        'hpower':hpower,
        'passcode':passcode,
        'wallet':wallet
      }
  );
}


class AuthService {

  /// Google Sign In
  Future<void> signInWithGoogle() async {
    // begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // obtain auth detail from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // sign in with the credential
    await FirebaseAuth.instance.signInWithCredential(credential);

    // get the user's email and wait for the completion of getDoc()
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    if (userEmail != null) {
      await getDoc(userEmail);
    }

    // navigate to PassService screen

  }

  Future<void> getDoc(String userEmail) async {
    final doc = await FirebaseFirestore.instance.collection('user').doc(userEmail).get();
    if (!doc.exists) {
      await addUserDetails(userEmail, acct_balance.toDouble(), hpower, passcode, wallet);
    }
  }
}
