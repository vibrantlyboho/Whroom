import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whroomapp1/src/services/occupancyService.dart';

import 'home.dart';
import 'login.dart';
import 'occupancy.dart';

final auth= FirebaseAuth.instance;

class SingleBusScreen extends StatelessWidget {
  final String bonnetid;
  final String from;
  final String to;
  final List<dynamic> stops;
  const SingleBusScreen({Key? key, required this.bonnetid, required this.from, required this.to, required this.stops}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Details'),
        backgroundColor: Colors.yellow[700],
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              icon: const Icon(Icons.home)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_outlined)),
          IconButton(
              onPressed: () {
                auth.signOut();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    LoginScreen()), (Route<dynamic> route) => false);
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          children: <Widget>[
            SizedBox(height: 10,),
            CircleAvatar(
              backgroundImage: AssetImage('assets/bus.jpeg'), radius: 100,
            ),
            SizedBox(height: 10,),
            Center(
              child: Text(bonnetid, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 25, color: Colors.yellow[800])),
            ),
            SizedBox(height:10),
            Row(mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(width: 80,
                      height: 80,
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
                      decoration: BoxDecoration(
                          shape: BoxShape.circle), child:Image(image: AssetImage('assets/get-off-bus.png'))
                  ),
                  SizedBox(width: 20,),
                  Text(to, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 25, color: Colors.yellow[800])),
                ]),
            SizedBox(height:30),
            Text('BUS STOPS', style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 25, color: Colors.yellow[800])),
            SizedBox(height: 10,),
            BusStopsDisplay(stops),
            SizedBox(height:10),
            BoardOrExit(bonnetid: bonnetid),
          ],
        ),
      ),
    );
  }
}



BusStopsDisplay(List<dynamic> stops){
  //print(stops);
  String BusStopsList='';
  for(int i=0; i<stops.length; i++){
    BusStopsList+= stops[i]+", ";
  }
  //print(BusStopsList);
  return Text(BusStopsList, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 25));
}


///////////////////
class BoardOrExit extends StatefulWidget {
  String bonnetid;
  BoardOrExit({Key? key, required this.bonnetid, }) : super(key: key);

  @override
  _BoardOrExitState createState() => _BoardOrExitState();
}

class _BoardOrExitState extends State<BoardOrExit> {
  bool isBoarded= false;

  void toggleBoard(){
    setState(() {
      isBoarded = !isBoarded;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 0, 20),
      child: Column(
        children: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20,),
            ),
            onPressed: () {
              final Occupancy occupancy= Occupancy(widget.bonnetid);
              dynamic OccDetails= occupancy.getOccdetails();
              //print(OccDetails);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => OccupancyScreen(bonnetid: widget.bonnetid, isBoarded: isBoarded, OccDetails: OccDetails)));
            },
            child: const Text('Passenger review on seat occupancy'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.yellow[700]),
            ),
            onPressed: () {
              toggleBoard();
            },
            child: Text((isBoarded? 'Exit': 'Board the bus'),style: TextStyle(fontSize: 17),),
          ),
        ],
      ),
    );
  }
}
