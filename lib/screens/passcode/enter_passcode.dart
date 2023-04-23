import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:voskcoin/components/my_textfield.dart';
import '../../components/my_text.dart';
import '../../components/screen_utils.dart';
import '../auth/error_msg.dart';
import '../dashboard/bottombar.dart';
class EnterPasscode extends StatefulWidget {
  const EnterPasscode({Key? key}) : super(key: key);

  @override
  State<EnterPasscode> createState() => _EnterPasscodeState();
}

class _EnterPasscodeState extends State<EnterPasscode> {
  bool _isLoad = false;
  var selectedindex = 0;
  int _failedAttempts = 0;
  String code = '';
  final user = FirebaseAuth.instance.currentUser!;

  Future<void> checkPasscode(String code) async {
    setState(() {
      _isLoad = true;
    });

    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      try {
        final userDoc = await FirebaseFirestore.instance
            .collection('user')
            .doc(user.email)
            .get();

        final String passcode = userDoc.data()!['passcode'];

        if (code == passcode) {
          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              _isLoad = false;
            });
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return Bottombar();
              }),

            );
            _failedAttempts = 0; // reset failed attempts on successful login
          });
        } else {
          _failedAttempts++;
          if (_failedAttempts >= 3) {
            admin.auth().updateUser(uid, { disabled: true });
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(AccountDisabled);
            SignUserOut();
          } else {
            Future.delayed(Duration(seconds: 3), () {
              setState(() {
                _isLoad = false;
              });
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(PasscodeWrong);
            });
          }
        }
      } catch (e) {
        setState(() {
          _isLoad = false;
        });
        print(e);
      }
    } else {
      setState(() {
        _isLoad = false;
      });
      print('no internet connection');
    }
  }

  void SignUserOut(){
    FirebaseAuth.instance.signOut();

  }
  @override

  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var kverifyColor = const Color(0xff038a2e);
    ScreenUtils().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Container(
          height: height * 1,
          width: width,

          child:Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(

                  child:  Padding(
                    padding: EdgeInsets.only(top: getProportionateScreenHeight(60)),
                    child:Padding(
                      padding: const EdgeInsets.only(left:12.0,right: 12),
                      child: Column(
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            "assets/images/flash_logo.png"
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Text('Welcome,', style:Styles.headLineStyle3.copyWith(fontFamily: "PlayfairDisplay",fontSize: 16)),
                                      const SizedBox(width: 5,),
                                      Text(user.email.toString(), style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black)),
                                    ],
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap:SignUserOut,
                                child: Container(
                                  height: 27,
                                  width: 27,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "assets/images/logout.png"
                                          )
                                      )
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ),



                ),
              ),
              SizedBox(height: 70,),
Visibility(
  visible: _isLoad,
    child: CustomCircularProgressIndicator(size: 20)),
              SizedBox(height: 50,),
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
                          code: code,
                        ),
                        DigitHolder(
                            width: width,
                            index: 1,
                            selectedIndex: selectedindex,
                            code: code),
                        DigitHolder(
                            width: width,
                            index: 2,
                            selectedIndex: selectedindex,
                            code: code),
                        DigitHolder(
                            width: width,
                            index: 3,
                            selectedIndex: selectedindex,
                            code: code),

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
                            color: Colors.transparent,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                              Expanded(
                              flex: 1,
                              child: Container(
                                  height: double.maxFinite,

                                  child: TextButton(
                                      onPressed: () {
                                        checkPasscode(code);

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
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                SizedBox(height: 20,),
                                Center(child: Container(
                                  child:Text('Forgot Pin')
                                ))
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
    if (code.length > 3) {
      return;
    }
    setState(() {
      code = code + digit.toString();
      print('Code is $code');
      selectedindex = code.length;
    });
  }

  backspace() {
    if (code.length == 0) {
      return;
    }
    setState(() {
      code = code.substring(0, code.length - 1);
      selectedindex = code.length;
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
