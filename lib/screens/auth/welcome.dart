import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:voskcoin/screens/auth/services/auth_services.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '/components/my_textfield.dart';
import '/components/square_tile.dart';
import 'forgot_pwd.dart';
import 'signup.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  double _sigmaX = 5;
 // from 0-10
  double _sigmaY = 5;
 // from 0-10
  double _opacity = 0.2;

  double _width = 300;

  double _height = 300;

  final _formKey = GlobalKey<FormState>();

  // sign user in method
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();



  Future<void> loginUserGmail() async {
    AuthService().signInWithGoogle();



  }


    //sign user in
  void SignUserIn() async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text);
      setState(() {});
    } on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        print('user not found');
        _btnController.error();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            elevation: 10,
              backgroundColor: Colors.black,
              content: Text('User Not Found')),
        );
      }else  if(e.code == 'wrong-password'){
        _btnController.error();
        print('wrong password');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              elevation: 10,
              backgroundColor: Colors.black,
              content: Text('Wrong Password')),
        );
      } else{
        print(e.code);
      };
    }
  }


  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _doSomething() async {

    Timer(Duration(seconds: 3), () {
        SignUserIn();
        Timer(Duration(seconds: 3), () {
          _btnController.reset();
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/bg.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  const Text("Let's Mine !",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontFamily: 'PlayfairDisplay',
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ClipRect(
                    child: BackdropFilter(
                      filter:
                      ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 1)
                                .withOpacity(_opacity),
                            borderRadius:
                            BorderRadius.all(Radius.circular(30))),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.63,
                        child: Form(
                          key: _formKey,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // username textfield
                                MyTextField(
                                  controller: emailController,
                                  hintText: 'Email',
                                  obscureText: false,
                                ),

                                const SizedBox(height: 10),
                                TextFormField(
                                  validator: (val) => val!.length < 6 ? 'Password too short.' : null,
                                  controller: passwordController,
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                      suffixIcon: InkWell(onTap: _toggle,
                                          child: const Icon(Icons.visibility_off)),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey.shade400),
                                      ),
                                      fillColor: Colors.grey.shade200,
                                      filled: true,
                                      hintText: 'Password',
                                      hintStyle: TextStyle(color: Colors.grey[500])),
                                ),
                                const SizedBox(height: 30),

                                // sign in button
                                RoundedLoadingButton(
                                  color: Color.fromARGB(255, 71, 233, 133),
                                  borderRadius: 10,
                                  width: MediaQuery.of(context).size.width * 0.85,
                                  child: Text('Sign In', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 19)),
                                  controller: _btnController,
                                  onPressed: (){
                                    FocusScope.of(context).unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    _doSomething();

                           }else{
                                    _btnController.reset();
                                  }
                                  },
                                ),

                                const SizedBox(height: 20),

                                // or continue with
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        'Or',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),

                                // google + apple sign in buttons
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  [

                                      // google button
                                      InkWell(
                                        onTap: ()=> loginUserGmail(),
                                        child: SquareTile(
                                          imagePath: 'assets/images/google.png',
                                          title: "Continue with Google",
                                        ),
                                      ),

                                      SizedBox(height: 10),

                                     ],
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // not a member? register now
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Text(
                                            'Don\'t have an account?',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                            textAlign: TextAlign.start,
                                          ),
                                          const SizedBox(width: 4),
                                          InkWell(
                                            onTap: (){
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType.rightToLeft,
                                                  isIos: true,
                                                  child: Signup(),
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              'Sign Up',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 71, 233, 133),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.01),
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.rightToLeft,
                                              isIos: true,
                                              child: ForgotPwd(),
                                            ),
                                          );
                                        },
                                        child: const Text('Forgot Password?',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 71, 233, 133),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                            textAlign: TextAlign.start),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}