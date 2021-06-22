import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';
import 'package:whroomapp1/src/services/occupancyService.dart';

final auth= FirebaseAuth.instance;

class CreateNewOccupancyScreen extends StatefulWidget {
  String bonnetid;
  CreateNewOccupancyScreen({Key? key, required this.bonnetid}) : super(key: key);

  @override
  _CreateNewOccupancyScreenState createState() => _CreateNewOccupancyScreenState();
}

class _CreateNewOccupancyScreenState extends State<CreateNewOccupancyScreen> {
  String option= 'Empty';
  int voteCount= 0;
  final currentuser= FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Entry'),
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
      body: Container(
        padding: new EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text('How is the occupancy in the bus?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.yellow[700]),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: (option =="Empty") ? MaterialStateProperty.all(Colors.yellow[700]) : MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                setState(() {
                  option= 'Empty';
                });
              },
              child: Text('Empty', style: TextStyle(fontSize: 17),)
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: (option =="Seats Available") ? MaterialStateProperty.all(Colors.yellow[700]) : MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {
                  setState(() {
                    option= 'Seats Available';
                  });
                },
                child: Text('Seats Available', style: TextStyle(fontSize: 17),)
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: (option =="Few Seats Available") ? MaterialStateProperty.all(Colors.yellow[700]) : MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {
                  setState(() {
                    option= 'Few Seats Available';
                  });
                },
                child: Text('Few Seats Available', style: TextStyle(fontSize: 17),)
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: (option =="No Seats Available") ? MaterialStateProperty.all(Colors.yellow[700]) : MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {
                  setState(() {
                    option= 'No Seats Available';
                  });
                },
                child: Text('No Seats Available', style: TextStyle(fontSize: 17),)
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: (option =="Standing") ? MaterialStateProperty.all(Colors.yellow[700]) : MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {
                  setState(() {
                    option= 'Standing';
                  });
                },
                child: Text('Standing', style: TextStyle(fontSize: 17),)
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20,),
              ),
              onPressed: () {
                /*print(widget.bonnetid);
                print(option);
                print(voteCount);
                print(currentuser!.uid);*/
                Occupancy occupancy= Occupancy(widget.bonnetid);
                occupancy.addOccdetails(widget.bonnetid, option, voteCount, currentuser!.uid);
                Navigator.pop(context);
                },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
