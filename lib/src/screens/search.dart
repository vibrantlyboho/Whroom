import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whroomapp1/src/screens/login.dart';


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
    );
  }
}



