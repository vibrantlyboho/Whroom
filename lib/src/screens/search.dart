import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whroomapp1/src/screens/login.dart';
import 'package:whroomapp1/src/services/readBus.dart';


class SearchScreen extends StatefulWidget {
  final String from;
  final String to;


  const SearchScreen({Key? key, required this.from, required this.to}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final auth= FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    final busRef= FirebaseFirestore.instance.collection('bus');


    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
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
      body: StreamBuilder(
        stream: busRef.snapshots(),
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
                            print("tapped");
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text("Bonnet ID: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey[700]),),
                                  Text(snapshot.data!.docs[index].get('bonnetid'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey[700]),),
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
    );
  }
}



class Bus{
  dynamic bonnetid;
  dynamic isRunning;
  dynamic stops;
}

