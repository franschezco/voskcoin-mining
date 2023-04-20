import 'package:flutter/material.dart';
import 'package:voskcoin/screens/auth/auth_page.dart';

class Check extends StatelessWidget {
  const Check({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PassService(),
    );
  }
}
