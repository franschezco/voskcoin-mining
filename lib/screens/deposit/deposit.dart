import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../components/my_textfield.dart';
import 'depositpop.dart';
class DepositScreen extends StatefulWidget {
  const DepositScreen({Key? key}) : super(key: key);

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

double _usdAmount = 0.0;
double _btcAmount = 0.0;

// Define a function to show the BottomSheet
void bottomsheets(BuildContext context, double usdAmount, double btcAmount) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.55,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: DepositPop(
        usdAmount: usdAmount,
        btcAmount: btcAmount,
      ),
    ),
  );
}

class _DepositScreenState extends State<DepositScreen> {
  bool isLoading = false;
  final _usdController = TextEditingController();
  final _btcController = TextEditingController();
  Future<void> _convertUsdToBtc() async {
    final url = Uri.parse('https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final btcPrice = data['bitcoin']['usd'];
      final btcAmount = _usdAmount / btcPrice;
      setState(() {
        _btcAmount = btcAmount;
        _btcController.text = _btcAmount.toStringAsFixed(6);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void dispose() {
    _usdController.dispose();
    _btcController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child:Column(
            children: [
              Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
               Text('Deposit',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
               Container(
                 decoration: BoxDecoration(
                   color: Colors.grey[400],
                   shape: BoxShape.circle
                 ),
                   child: Icon(Icons.add)),

                ],
      )),

              SizedBox(height: 30,),
              Container(
                width: 350,
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration( gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 1),
                    colors: <Color>[
                      Color(0xff19A186),
                      Color(0xffF2CF43),
                    ],
                    tileMode: TileMode.mirror,),
                  borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0,right: 12),
                        child: Center(child: AmountTextField(
                          enabled: true,
                          controller: _usdController,
                          currencySymbol: 'USDT',
                          onchanged: (value) {
                            if (value.isEmpty) {
                              setState(() {
                                _btcController.text = '';
                              });
                              return;
                            }
                            final usdAmount = double.tryParse(value);
                            if (usdAmount == null) {
                              setState(() {
                                _btcController.text = '';
                              });
                              return;
                            }
                            setState(() {
                              _usdAmount = usdAmount;
                              _convertUsdToBtc();
                            });
                          },
                        ),
                        )
                          ),
                      SizedBox(height: 15,),
                      Center(child: Image.asset(
                        'assets/images/exchange.png', // replace with your image path
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover, // set how the image should be fitted within its bounds
                      ),),
                      SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0,right: 12),
                        child: Center(child: AmountTextField(
                          enabled: false,
                          onchanged: (value){},
                          controller: _btcController,
                          currencySymbol: 'BTC',
                        )),
                      ),
                    ],
                  )),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: DepositButton(
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });

                    print('loading');
                    bottomsheets(context,_usdAmount, _btcAmount);
                    setState(() {
                      isLoading = false;
                    });
                  },
                  label: 'Deposit Funds',
                  isLoading: isLoading,
                )

              )
            ],

           ) ,
        ),
    );
  }
}



