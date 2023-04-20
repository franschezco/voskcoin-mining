import 'package:flutter/material.dart';

import '../../components/my_text.dart';
class Cards extends StatelessWidget {
  String balance;
   Cards({Key? key, required this.balance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20,bottom: 20),
      width: 320,
      decoration: BoxDecoration(
      gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment(0.8, 1),
      colors: <Color>[
        Color(0xff19A186),
        Color(0xffF2CF43),
      ],
      tileMode: TileMode.mirror,),
          borderRadius: BorderRadius.circular(16)

      ),
      child: Stack(children: [
          Positioned(
          top: -45,
          right: -50,child: Container(padding: EdgeInsets.all(37),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(width: 25, color: Color(0xff63D471)))),),
         Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Text("Balance",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color:Colors.white,fontFamily: 'PlayfairDisplay'),),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.account_balance_wallet),
                  SizedBox(width: 10,),
                  Text("\$",style:Styles.headLineStyle.copyWith(fontFamily: 'PlayfairDisplay')),
                  Text(balance,style:Styles.headLineStyle.copyWith(fontFamily: 'PlayfairDisplay')),
                ],
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('USDT/BTC',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: "PlayfairDisplay")),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Column(
                      children: [
                        Text("Horsepower",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: "PlayfairDisplay")),
                        Text('100GH/Z',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: "PlayfairDisplay"))
                      ],
                    ),
                  )

                ],
              ),
              SizedBox(height: 10,),
            ],
          ),
    ]),
    );
  }
}
