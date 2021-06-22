import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whroomapp1/src/screens/createnewoccupancy.dart';
import 'package:whroomapp1/src/services/occupancyService.dart';

import 'home.dart';
import 'login.dart';

final auth= FirebaseAuth.instance;
final currentuser= FirebaseAuth.instance.currentUser;

class OccupancyScreen extends StatefulWidget {
  final String bonnetid;
  final bool isBoarded;
  Future<QuerySnapshot> OccDetails;

  OccupancyScreen({Key? key, required this.bonnetid, required this.isBoarded, required this.OccDetails}) : super(key: key);

  @override
  _OccupancyScreenState createState() => _OccupancyScreenState();
}

class _OccupancyScreenState extends State<OccupancyScreen> {
  final snackBarUpVote = SnackBar(content: Text('You have upvote the entry'));
  final snackBarDelete = SnackBar(content: Text('Deleting your entry'));
  final snackBarRequest = SnackBar(content: Text('Please board the bus to upvote or create new entries'));
  Occupancy occupancyService= Occupancy.plain();

  @override
  Widget build(BuildContext context) {
    //print(widget.isBoarded);
    //print(currentuser!.uid);


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
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    LoginScreen()), (Route<dynamic> route) => false);
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
                            String snapid= snapshot.data!.docs[index].id;
                            //widget.isBoarded? print("Upvoting"): null;
                            //print(snapshot.data!.docs[index].id);
                            if(widget.isBoarded){
                              if(currentuser!.uid == snapshot.data!.docs[index].get('uid')){
                                ScaffoldMessenger.of(context).showSnackBar(snackBarDelete);
                                print("Deleting your entry");
                                occupancyService.deleteEntryOnTap(snapid);
                              }
                              else{
                                ScaffoldMessenger.of(context).showSnackBar(snackBarUpVote);
                                occupancyService.upVote(snapid);
                              }
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(snackBarRequest);
                              print('Please board the bus to upvote or create new entries');
                            }

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
                                  Text('Vote Count: ', style: TextStyle(fontSize: 15, color: Colors.grey[700]),),
                                  SizedBox(width: 10,),
                                  Text(snapshot.data!.docs[index].get('voteCount').toString(), style: TextStyle(fontSize: 15, color: Colors.grey[700]),),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  SizedBox(width: 10,),
                                  currentuser!.uid == snapshot.data!.docs[index].get('uid')?
                                  Text('Your Entry', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.red[700]),) :
                                  Text('Submitted by:   ${snapshot.data!.docs[index].get('uid')}', style: TextStyle(fontSize: 15, color: Colors.grey[700]),),
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
