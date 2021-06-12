import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

final auth= FirebaseAuth.instance;

class SingleBusScreen extends StatelessWidget {
  final String bonnetid;
  final String from;
  final String to;
  const SingleBusScreen({Key? key, required this.bonnetid, required this.from, required this.to}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Details'),
        backgroundColor: Colors.yellow[700],
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.home)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_outlined)),
          IconButton(
              onPressed: () {
                auth.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        child:Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            CircleAvatar(
              backgroundImage: AssetImage('assets/bus.jpeg'), radius: 100,
            ),
            SizedBox(height: 10,),
            Text(bonnetid, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            SizedBox(height:10),
            Row(mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(width: 80,
                      height: 80,
                      padding: EdgeInsets.fromLTRB(30,0,0,0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle), child:Image(image: AssetImage('assets/get-on-bus.png'))
                  ),
                  SizedBox(width: 20,),
                  Text(from, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 25, color: Colors.yellow[800])),
                ]),
            SizedBox(height:10),
            Row(mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(width: 80,
                      height: 80,
                      padding: EdgeInsets.fromLTRB(30,0,0,0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle), child:Image(image: AssetImage('assets/get-off-bus.png'))
                  ),
                  SizedBox(width: 20,),
                  Text(to, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 25, color: Colors.yellow[800])),
                ]),
            SizedBox(height:30),
            Text('PASSENGER REVIEW ON SEAT OCCUPANCY', style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 15)),
            SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: (){},
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration:
                    BoxDecoration(
                      color: Colors.yellow[700],
                      shape: BoxShape.circle,
                      boxShadow: [ BoxShadow(
                        color: Colors.black,
                        blurRadius: 5.0, // soften the shadow
                        spreadRadius: 0.0, //extend the shadow
                        offset: Offset(
                          2.0, // Move to right 10  horizontally
                          2.0, // Move to bottom 10 Vertically
                        ),
                      )],
                    ),
                    child: Center(child: Text('Empty',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)),
                  ),
                ),
                InkWell(
                  onTap: (){},
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    decoration:
                    BoxDecoration(
                      color: Colors.yellow[700],
                      shape: BoxShape.circle,
                      boxShadow: [ BoxShadow(
                        color: Colors.black,
                        blurRadius: 5.0, // soften the shadow
                        spreadRadius: 0.0, //extend the shadow
                        offset: Offset(
                          2.0, // Move to right 10  horizontally
                          2.0, // Move to bottom 10 Vertically
                        ),
                      )],
                    ),
                    child: Center(child: Text('Available',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)),
                  ),
                ),
              ],
            ),
            SizedBox(height:10),
            Container(padding: const EdgeInsets.fromLTRB(20, 10, 0, 20), child: Align(alignment: Alignment.centerLeft,
              child:ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.yellow[700]),
                ),
                onPressed: () {

                },
                child: Text('Board the bus',style: TextStyle(fontSize: 17),),
              ), ))  ,
          ],
        ),
      ),
    ),
    );
  }
}

