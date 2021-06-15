import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whroomapp1/src/screens/createnewoccupancy.dart';

import 'home.dart';
import 'login.dart';

final auth= FirebaseAuth.instance;

class OccupancyScreen extends StatefulWidget {
  final String bonnetid;
  final bool isBoarded;
  Future<QuerySnapshot> OccDetails;

  OccupancyScreen({Key? key, required this.bonnetid, required this.isBoarded, required this.OccDetails}) : super(key: key);

  @override
  _OccupancyScreenState createState() => _OccupancyScreenState();
}

class _OccupancyScreenState extends State<OccupancyScreen> {
  @override
  Widget build(BuildContext context) {
    //print(widget.isBoarded);

    displayFAB(){
      if(widget.isBoarded){
        return FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateNewOccupancyScreen(bonnetid: widget.bonnetid,)));
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.yellow[700],
        );
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Occupancy Details'),
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
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: FutureBuilder(
        future: widget.OccDetails,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData){
            return Container(
              height: 600,
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                    return Container(
                      height: 100,
                      child: Card(
                        child: new InkWell(
                          onTap: () {
                            widget.isBoarded? print("Upvoting"): null;
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Icon(Icons.check_circle, color: Colors.yellow[700],),
                                  SizedBox(width: 10,),
                                  Text(snapshot.data!.docs[index].get('option'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.yellow[700]),),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Text('Submitted by: ', style: TextStyle(fontSize: 15, color: Colors.grey[700]),),
                                  SizedBox(width: 10,),
                                  Text(snapshot.data!.docs[index].get('uid'), style: TextStyle(fontSize: 15, color: Colors.grey[700]),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }
          else if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          else{
            return CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: displayFAB(),
    );
  }
}
