import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';

final auth= FirebaseAuth.instance;
final currentuser= FirebaseAuth.instance.currentUser;


class ViewLocationScreen extends StatefulWidget {
  const ViewLocationScreen({Key? key}) : super(key: key);

  @override
  _ViewLocationScreenState createState() => _ViewLocationScreenState();
}

class _ViewLocationScreenState extends State<ViewLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
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

    );
  }
}
