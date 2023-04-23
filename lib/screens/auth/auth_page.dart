
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voskcoin/screens/auth/welcome.dart';

import '../../components/my_textfield.dart';
import '../passcode/enter_passcode.dart';
import '../passcode/set_passcode.dart';

class PassService extends StatefulWidget {
  const PassService({Key? key}) : super(key: key);

  @override
  State<PassService> createState() => _PassServiceState();
}

class _PassServiceState extends State<PassService> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(   backgroundColor: Colors.white70,
              body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasData && snapshot.data != null) {
          final user = snapshot.data!;
          return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.collection('user').doc(user.email).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                print('Error: ${snapshot.error}');
              }

              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                      body: Center(child:CustomCircularProgressIndicator(
                        size: 30,
                      )
                      ));
                default:
                  if (snapshot.data == null || !snapshot.data!.exists) {
                    print('Document does not exist.');
                    return WelcomePage();
                  }
                  final data = snapshot.data!.data() as Map<String, dynamic>;
                  print('fault from me');

                  if (data['passcode']=='default'){
                    print('set passcode');

                      return PasswordView();
                  } else {
                    print('view enterpasscode');

                    return EnterPasscode();
                  }
              }
            },
          );
        } else {
          return WelcomePage(); // replace LoginPage with your implementation
        }
      },
    );
  }
}

