import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whroomapp1/src/models/bus.dart';
import 'package:whroomapp1/src/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whroomapp1/src/services/readBus.dart';

class FindScreen extends StatelessWidget {


  final String bonnetid;
  Future<Null> busDetails;
  final auth= FirebaseAuth.instance;
  final Stream<QuerySnapshot> _Stream = FirebaseFirestore.instance.collection('bus').snapshots();
  FindScreen({Key? key, required this.bonnetid, required this.busDetails}) : super(key: key);
  //final ReadBus bus= ReadBus();
  //final Stream<List<Bus>> _busStream = bus.getwithBonnetid();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find my bus'),
        backgroundColor: Colors.yellow[700],
        actions: [
          IconButton(
              onPressed: (){},
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
      body: Text('Bus Details: $busDetails, ${busDetails.runtimeType}'),
    );
  }
}



/*

class FindScreen extends StatefulWidget {
  const FindScreen({Key? key}) : super(key: key);

  @override
  _FindScreenState createState() => _FindScreenState();
}

class _FindScreenState extends State<FindScreen> {
  final auth= FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find my bus'),
        backgroundColor: Colors.yellow[700],
        actions: [
          IconButton(
              onPressed: (){},
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
    );
  }
}


 */