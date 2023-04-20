import 'package:flutter/material.dart';
import 'package:voskcoin/screens/deposit/wallet.dart';

class DepositPop extends StatelessWidget {
  final double usdAmount;
  final double btcAmount;
  const DepositPop({Key? key,required this.usdAmount, required this.btcAmount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>false,
      child: Container(child:
      Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [

            Column(
              children: [SizedBox(height: 10,),
                Center(
                  child:Image.asset('assets/images/save-money.gif', width: 200,
                    height: 200,
                    fit: BoxFit.cover,),
                ),
                SizedBox(height: 30,),
                Text('You are about to deposit $usdAmount USD \n equivalent to \$${btcAmount.toStringAsFixed(6)} BTC !', textAlign: TextAlign.center,style: TextStyle(
                    fontFamily: "Inter",
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 18
                )),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => WalletScreen()));
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 19,horizontal:15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:  Colors.green,
                        ),
                        child:Center(
                          child: Text(
                            "Generate Wallet Address", textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          )
                            ,

                          ),
                        )
                    ),
                  ),
                ),

              ],
            ),


          ],
        ),

      ),
      ),
    );
  }
}
