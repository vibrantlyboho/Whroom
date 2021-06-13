import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whroomapp1/src/models/bus.dart';
import 'package:whroomapp1/src/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whroomapp1/src/screens/singlebus.dart';
import 'package:whroomapp1/src/services/readBus.dart';

import 'home.dart';

class FindScreen extends StatefulWidget {


  final String bonnetid;
  Future<QuerySnapshot> busDetails;

  FindScreen({Key? key, required this.bonnetid, required this.busDetails}) : super(key: key);

  @override
  _FindScreenState createState() => _FindScreenState();
}

class _FindScreenState extends State<FindScreen> {
  final auth= FirebaseAuth.instance;

  final Stream<QuerySnapshot> _Stream = FirebaseFirestore.instance.collection('bus').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find my bus'),
        backgroundColor: Colors.yellow[700],
        actions: [
          IconButton(
              onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              icon: const Icon(Icons.home)
          ),
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.favorite_outlined)
          ),
          IconButton(
              onPressed: (){
                auth.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: const Icon(Icons.logout)
          ),
        ],
      ),
      body: FutureBuilder(
        future: widget.busDetails,
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
                            String bonnetid= snapshot.data!.docs[index].get("bonnetid");
                            String from= snapshot.data!.docs[index].get("from");
                            String to= snapshot.data!.docs[index].get("to");
                            List<dynamic> stops= snapshot.data!.docs[index].get("stops");
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SingleBusScreen(bonnetid: bonnetid, from: from, to: to, stops: stops,)));
                            print(snapshot.data!.docs[index].get("bonnetid"));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Icon(Icons.directions_bus),
                                  Text(snapshot.data!.docs[index].get('bonnetid'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.yellow[700]),),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.flag),
                                  Text(snapshot.data!.docs[index].get('from'), style: TextStyle(fontSize: 20, color: Colors.grey[700]),),
                                  SizedBox(width: 20,),
                                  Icon(Icons.pin_drop),
                                  Text(snapshot.data!.docs[index].get('to'), style: TextStyle(fontSize: 20, color: Colors.grey[700]),),
                                  //Text(snapshot.data!.docs[index].get('stops'), style: TextStyle(fontSize: 20, color: Colors.grey[700]),),
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
      //Text('Bus Details: $busDetails, ${busDetails.runtimeType}'),
    );
  }
}
