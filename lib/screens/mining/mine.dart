import 'package:flutter/material.dart';
class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: ListView.builder(
                  itemCount: 3,
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
                              child: Row(
                                children: [
                                  Text('Status'),
                                  Text('Status')
                                ],
                              ),
                            ),
                          ),

                          onTap: () {
                          },
                        ),
                      ),
                    );
                  }))
            ],
          ),
        )
    );
  }
}
