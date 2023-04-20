import 'package:flutter/material.dart';

import '../dashboard/bottombar.dart';
class SuccessPass extends StatelessWidget {
  const SuccessPass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      return false; // Prevent the user from going back
    },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                  children: [

                    SizedBox(height: 20),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 40),
                          Center(

                            child: Image(
                              image: AssetImage('assets/images/business.png'),
                              width: 120,
                              height: 120,
                            ),),SizedBox(height: 20),
                          Center(
                              child: Text('Passcode Has been Updated!',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontFamily: 'Inter',
                                  fontWeight: FontWeight.w800,fontSize: 20),)
                          ),
                          SizedBox(height: 10),
                          Center(
                              child: Text('Your passcode has been set successfully.\n ',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,fontSize: 14),)
                          ),


                        ]),
                    SizedBox(height: 320,),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return  Bottombar();}));

                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 19,horizontal:15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:  Colors.green,
                          ),
                          child:const Center(
                            child: Text(
                              " Explore Dashboard ", textAlign: TextAlign.center,style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16
                            )
                              ,

                            ),
                          )
                      ),
                    )

                  ]))),
    );
  }
}