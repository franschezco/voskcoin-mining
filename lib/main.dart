import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:voskcoin/screens/onboarding/check.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner:false,
        home:
        AnimatedSplashScreen(
            backgroundColor:Colors.white ,
            splash: 'assets/images/flash_logo.png',
            nextScreen:  Check(),
            pageTransitionType: PageTransitionType.rightToLeftWithFade

        )
    );
  }
}