import 'package:flutter/material.dart';
class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Complete Transaction',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      shape: BoxShape.circle
                  ),
                  child: Icon(Icons.add)),

            ],
          )),

      SizedBox(height: 30,),

            Center(
              child:Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                height:200,
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Image.asset(
                    'assets/images/barcode.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
               ),
              ),
          ],
        ),

      ),
    );
  }
}
