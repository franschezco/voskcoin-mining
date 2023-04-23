import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../../components/my_text.dart';
import '../../deposit/deposit.dart';
import 'quick_dial.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? balance;
  int? horsepower;
final user = FirebaseAuth.instance.currentUser!;


  void getDetails() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('user')
        .doc(user.email.toString())
        .get();
    print(userDoc.data());
    balance = userDoc.data()!['balance'];
    print(balance);
    horsepower = userDoc.data()!['hpower'];
    print(horsepower);
    setState(() {
      balance = userDoc.data()!['balance'];
      horsepower = userDoc.data()!['hpower'];
    });
  }

  void SignUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  @override

  Widget build(BuildContext context) {
    final double screenHeight=MediaQuery.of(context).size.height;
    final double screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
          children: [
          Positioned(
          top: 0,left: 0,right: 0,height: screenHeight/3,
          child:
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 1),
                  colors: <Color>[
                    Color(0xff19A186),
                    Color(0xffF2CF43),
                  ],
                  tileMode: TileMode.mirror,),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),

            ),
          )),
      Positioned(
          top: 0,right: 0,left: 0,
          child: Column(
            children: [
              AppBar(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                leading:  Spacer(),
                actions: [
                  IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.notifications),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        "Good Morning, " + user.displayName.toString(),
                        overflow: TextOverflow.ellipsis,
                          style:Styles.headLineStyle.copyWith(fontFamily: 'PlayfairDisplay',fontSize: 16)
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:12.0,right: 12,bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text("Balance",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color:Colors.white,fontFamily: 'PlayfairDisplay'),),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.account_balance_wallet),
                        SizedBox(width: 10,),
                        Text("\$",style:Styles.headLineStyle.copyWith(fontFamily: 'PlayfairDisplay')),
                        Text('${balance?.toInt()?.toString() ?? '0'}',style:Styles.headLineStyle.copyWith(fontFamily: 'PlayfairDisplay')),Spacer(),
                        Column(
                            children: [
                              Text("Horsepower",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: "PlayfairDisplay")),
                              Text( (horsepower ?? 0).toInt().toString() +'GH/Z',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: "PlayfairDisplay"))
                            ]
                    ),
                  ],
                ),
            ],
          ),
              ),]),),
      Positioned(
        left: 0 ,right:0, top: screenHeight*0.3,
        height: screenHeight*0.30,
        child:Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
            color: Colors.white,
          ),
          child: Column(
              children: [

                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Quick Access", style: Styles.headLineStyle2.copyWith(fontFamily: "PlayfairDisplay" ),),
                      ],
                  ),
                ),
                SizedBox(height: 30,),

                SingleChildScrollView(
              scrollDirection:Axis.horizontal,padding: const EdgeInsets.only(left: 15,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    InkWell(onTap:(){
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          isIos: true,
                          child: DepositScreen(),
                        ),
                      );
                    },
                        child: QuickService(Btntext: 'Deposit', iconImagePath: 'assets/images/deposit.png',)),
                    QuickService(Btntext: 'Withdraw', iconImagePath: 'assets/images/withdraw.png',),
                    QuickService(Btntext: 'Hashpower', iconImagePath: 'assets/images/mining.png',),
                QuickService(Btntext: 'Mine', iconImagePath: 'assets/images/bitcoin-mining.png',),
                  QuickService(Btntext: 'Send', iconImagePath: 'assets/images/send.png',),
                  QuickService(Btntext: 'Invite', iconImagePath: 'assets/images/miner.png',),
                  ],
                )),
                SizedBox(height: 20,),


            ]),
          ),
        ),
           Positioned(
               top: screenHeight * 0.6, // adjust the value as needed
               left: 0,
               right: 0,
               bottom: 0,
               child: Container(
                 color: Colors.white,
             child: Column(
               children: [
                 Container(
                   padding: const EdgeInsets.symmetric(horizontal: 20),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("Recent Transactions", style: Styles.headLineStyle2.copyWith(fontFamily: "PlayfairDisplay"),),
                       InkWell(
                           onTap: SignUserOut,
                           child: Text("View all", style: Styles.textStyle.copyWith(color: Styles.primaryColor,fontFamily: "PlayfairDisplay"),))
                     ],
                   ),
                 ),
                 Expanded(child: ListView.builder(
                     itemCount: 9,
                     itemBuilder: (BuildContext context, int index){
                       return Padding(
                         padding: const EdgeInsets.only(left: 12.0,right: 12.0,top: 5),
                         child: Card(
                           elevation: 4.6,
                           color: Colors.white,
                           shape: RoundedRectangleBorder(

                             borderRadius: BorderRadius.circular(20),
                           ),
                           child: ListTile(

                             leading: CircleAvatar(
                               child: Container(
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(13.9),
                                     image: new DecorationImage(
                                       image: new AssetImage("assets/images/bitcoin.png"),
                                       fit: BoxFit.fill,
                                     )
                                 ),
                               ),
                             ),
                             trailing: Text("\$400",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.green,fontFamily: "PlayfairDisplay")),
                             title: Text("Deposit",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.green,fontFamily: "PlayfairDisplay")),
                             subtitle: Text('21 January 2022',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300,color: Colors.black45,)),
                             onTap: () {
                             },
                           ),
                         ),
                       );
                     }))

               ],
             ),
           ))

    ]));
  }}