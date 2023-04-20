import 'package:flutter/material.dart';

class QuickService extends StatelessWidget {
  final String iconImagePath;
  final String Btntext;
  const QuickService({Key? key,required this.Btntext,required this.iconImagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(right: 18.0),
      child: Column(
          children: [
            Container(
              height: 80,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(
                      color: Colors.white,
                      blurRadius: 10,
                      spreadRadius: 2
                  )]

              ),
              child: Center(
                child: Image.asset(iconImagePath),
              ),
            ),
            SizedBox(height: 10,),
            Text(Btntext ,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,fontFamily: "PlayfairDisplay",
              color:Colors.grey[700],),)
          ],
        ),
    );
  }
}
