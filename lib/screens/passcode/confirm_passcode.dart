import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:voskcoin/components/screen_utils.dart';
import 'package:voskcoin/screens/passcode/success.dart';

import '../auth/error_msg.dart';

class ConfirmPasscode extends StatefulWidget {

  const ConfirmPasscode({Key? key,required this.code}) : super(key: key);

  @override
  final String code;
  State<ConfirmPasscode> createState() => _ConfirmPasscodeState();
}

class _ConfirmPasscodeState extends State<ConfirmPasscode> {
  late String _code;
  var selectedindex = 0;
  String scode = '';

 @override
 void initState() {
   super.initState();
   _code = widget.code;
 }
  @override

  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var kverifyColor = const Color(0xff038a2e);
    ScreenUtils().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Container(
          height: height * 1,
          width: width,

          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(

                  child:  Padding(
                    padding: EdgeInsets.only(top: getProportionateScreenHeight(60)),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text('Confirm Passcode',style: TextStyle(
                              letterSpacing: 1.5,
                              fontFamily: "PlayfairDisplay",
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18
                          ),),
                        ),
                        SizedBox(height:getProportionateScreenHeight(20)),
                        Padding(
                          padding:EdgeInsets.only(left: getProportionateScreenWidth(30),right: getProportionateScreenWidth(30)),
                          child: Container(
                              child: Text("Re-enter previous passcode you just entered.",
                                textAlign: TextAlign.center,)
                          ),
                        )
                      ],
                    ),
                  ),



                ),

              ),

              Expanded(
                flex: 2,
                child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DigitHolder(
                          width: width,
                          index: 0,
                          selectedIndex: selectedindex,
                          code: scode,
                        ),
                        DigitHolder(
                            width: width,
                            index: 1,
                            selectedIndex: selectedindex,
                            code: scode),
                        DigitHolder(
                            width: width,
                            index: 2,
                            selectedIndex: selectedindex,
                            code: scode),
                        DigitHolder(
                            width: width,
                            index: 3,
                            selectedIndex: selectedindex,
                            code: scode),

                      ],
                    )),
              ),

              Expanded(
                flex: 5,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: double.maxFinite,
                                    child: TextButton(
                                        onPressed: () {
                                          addDigit(1);
                                        },
                                        child: Text('1', style: TextStyle(
                                          color: kverifyColor,
                                          fontSize: 40,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Inter",
                                        ))),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: double.maxFinite,
                                    child: TextButton(

                                        onPressed: () {
                                          addDigit(2);
                                        },
                                        child: Text('2', style: TextStyle(
                                          color: kverifyColor,
                                          fontSize: 40,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Inter",
                                        ))),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: double.maxFinite,
                                    child: TextButton(
                                        onPressed: () {
                                          addDigit(3);
                                        },
                                        child: Text('3', style: TextStyle(
                                          color: kverifyColor,
                                          fontSize: 40,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Inter",
                                        ))),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: double.maxFinite,
                                    child: TextButton(

                                        onPressed: () {
                                          addDigit(4);
                                        },
                                        child: Text('4', style: TextStyle(
                                          color: kverifyColor,
                                          fontSize: 40,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Inter",
                                        ))),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: double.maxFinite,
                                    child: TextButton(
                                        onPressed: () {
                                          addDigit(5);
                                        },
                                        child: Text('5', style: TextStyle(
                                          color: kverifyColor,
                                          fontSize: 40,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Inter",
                                        ))),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: double.maxFinite,
                                    child: TextButton(
                                        onPressed: () {
                                          addDigit(6);
                                        },
                                        child: Text('6', style: TextStyle(
                                          color: kverifyColor,
                                          fontSize: 40,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Inter",
                                        ))),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: double.maxFinite,
                                    child: TextButton(
                                        onPressed: () {
                                          addDigit(7);
                                        },
                                        child: Text('7', style: TextStyle(
                                          color: kverifyColor,
                                          fontSize: 40,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Inter",
                                        ))),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(height: double.maxFinite,
                                    child: TextButton(
                                        onPressed: () {
                                          addDigit(8);
                                        },
                                        child: Text('8', style: TextStyle(
                                          color: kverifyColor,
                                          fontSize: 40,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Inter",
                                        ))),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: double.maxFinite,
                                    child: TextButton(
                                        onPressed: () {
                                          addDigit(9);
                                        },
                                        child: Text('9', style:  TextStyle(
                                          color: kverifyColor,
                                          fontSize: 40,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Inter",
                                        ))),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      height: double.maxFinite,

                                      child: TextButton(
                                          onPressed: () {

                                            if ( _code == scode){
                                              // Get a reference to the document you want to update
                                              DocumentReference docRef = FirebaseFirestore.instance.collection('user').doc(user.email);

                                              docRef.update({'passcode': scode}).then((value) {
                                                print('Field updated successfully!');
                                                Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    type: PageTransitionType.rightToLeft,
                                                    isIos: true,
                                                    child: SuccessPass(),
                                                  ),
                                                );

                                              }).catchError((error) {
                                                print('Failed to update field: $error');
                                              });


                                            }else if (_code != scode){

                                              ScaffoldMessenger.of(context)
                                                ..hideCurrentSnackBar()
                                                ..showSnackBar(PasscodeUnmatch);
                                            }else if (scode.length != 4){
                                              ScaffoldMessenger.of(context)
                                                ..hideCurrentSnackBar()
                                                ..showSnackBar(CompletePasscode);
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 20.0,right: 10,bottom: 10),
                                            child: Center(
                                              child: Container(
                                                height: 105,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.green,
                                                ),
                                                child: Center(child: Text('GO',style:
                                                TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white,letterSpacing: 2.4),)),
                                              ),
                                            ),
                                          ))
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: double.maxFinite,
                                    child: TextButton(
                                        onPressed: () {
                                          addDigit(0);
                                        },
                                        child: Text('0', style:  TextStyle(
                                          color: kverifyColor,
                                          fontSize: 40,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Inter",
                                        ))),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: double.maxFinite,
                                    child: TextButton(
                                        onPressed: () {
                                          backspace();
                                        },
                                        child: Icon(Icons.backspace,
                                            color: kverifyColor,
                                            size: 30)),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              )
            ],
          ))
      ,
    );
  }

  addDigit(int digit) {
    if (scode.length > 3) {
      return;
    }
    setState(() {
      scode = scode + digit.toString();
      print('Code is $scode');
      selectedindex = scode.length;
    });
  }

  backspace() {
    if (scode.length == 0) {
      return;
    }
    setState(() {
      scode = scode.substring(0, scode.length - 1);
      selectedindex = scode.length;
    });
  }
}


class DigitHolder extends StatelessWidget {
  final int selectedIndex;
  final int index;
  final String code;
  const DigitHolder({
    required this.selectedIndex,
    Key? key,
    required this.width,
    required this.index,
    required this.code,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: width * 0.12,
      width: width * 0.12,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color:  Colors.transparent,
              offset: Offset(0, 0),
              spreadRadius: 1.5,
              blurRadius: 2,
            )
          ]),
      child: code.length > index
          ? Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            image: DecorationImage(
                image:  AssetImage('assets/images/_.png')
            )
        ),
      )
          : Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
            image: DecorationImage(
                image:  AssetImage('assets/images/+.png')
            )
        ),
      ),
    );
  }
}
