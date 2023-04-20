import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '/components/my_textfield.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'auth_page.dart';
import 'error_msg.dart';

class Signup extends StatefulWidget {
  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // text editing co+-*trollers
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var acct_balance = 0.00;
  var hpower = 100;
  var passcode = 'default';
  var wallet ='';




  double _sigmaX = 7;
 // from 0-10
  double _sigmaY = 7;
 // from 0-10
  double _opacity = 0.2;

  final _formKey = GlobalKey<FormState>();

  // create user in method
  CreateUsers() async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text);
      User? user = result.user;
      if (user != null) {
        //add display name for just created user
        user.updateDisplayName(nameController.text.trim());
        //get updated user
        await user.reload();
        user = await FirebaseAuth.instance.currentUser;

        addUserDetails(emailController.text.trim(), acct_balance.toDouble(), int.parse(hpower.toString()), passcode.toString(), wallet);
        //print final version to console
        print("Registered user:");
        print(user);
      setState(() {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            isIos: true,
            child: PassService(),
          ),
        );
      });}
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('email already exist in our system');
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(emailExitsnackBar);
      }
      else if (e.code == 'weak-password'){
        print('Password Weak');
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(weakPasswordsnackBar);

      }else if (e.code == 'invalid-email'){
        print('Invalid Email');
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(invalidEmailsnackBar);

      }else{
        print(e.code);
      };
    }

  }

   addUserDetails(String email, double acct_balance,int hpower,String passcode,String wallet) async{
    var users = await FirebaseFirestore.instance.collection("user").doc(email);

    users.set(
      {
        'email': email,
        'balance': acct_balance,
        'hpower':hpower,
        'passcode':passcode,
        'wallet':wallet
      }
    );
  }
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }



  void _doSomething() async {

    Timer(Duration(seconds: 3), () {
      CreateUsers();
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.18),
                  const Text("Sign Up",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ClipRect(
                    child: BackdropFilter(
                      filter:
                      ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(0, 0, 0, 1)
                                .withOpacity(_opacity),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(30))),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Form(
                          key: _formKey,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                    "Look like you don't have an account. Let's create a new account for",
                                    // ignore: prefer_const_constructors
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    textAlign: TextAlign.start),
                                // ignore: prefer_const_constructors

                                const SizedBox(height: 30),
                                MyTextField(
                                  controller: nameController,
                                  hintText: 'Full Name',
                                  obscureText: false,
                                ),
                                const SizedBox(height: 10),
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

                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                                  children: [
                                    RichText(
                                      text: const TextSpan(
                                        text: '',
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                            'By selecting Agree & Continue below, I agree to our ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          TextSpan(
                                              text:
                                              'Terms of Service and Privacy Policy',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 71, 233, 133),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    RoundedLoadingButton(
                                      color: Color.fromARGB(255, 71, 233, 133),
                                      borderRadius: 10,
                                      width: MediaQuery.of(context).size.width * 0.85,
                                      child: Text('Agree & Continue', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 19)),
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
                                  ],
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