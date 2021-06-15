import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whroomapp1/src/screens/login.dart';
import 'package:whroomapp1/src/screens/search.dart';
import 'package:whroomapp1/src/screens/find.dart';
import 'package:whroomapp1/src/services/readBus.dart';
import 'package:whroomapp1/src/models/Bus.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth= FirebaseAuth.instance;
  final currentuser= FirebaseAuth.instance.currentUser;
  String _from='', _to='', _bonnetid='';
  final PageController controller = PageController(initialPage: 0); //for PageView, changing between 2 screens

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
      body: PageView(
        /// [PageView.scrollDirection] defaults to [Axis.horizontal].
        /// Use [Axis.vertical] to scroll vertically.
        scrollDirection: Axis.horizontal,
        controller: controller,
        children: <Widget>[
          Container(
            padding: new EdgeInsets.all(10.0) ,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 8),
                  child: Text('On the lookout for a bus?',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.grey[700]),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 8),
                  child: TextField(
                      decoration: InputDecoration(
                          hintText: 'From'
                      ),
                      onChanged: (value){
                        setState(() {
                          _from = value.trim();
                        });
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 8),
                  child: TextField(
                      decoration: InputDecoration(
                          hintText: 'To'
                      ),
                      onChanged: (value){
                        setState(() {
                          _to = value.trim();
                        });
                      }),
                ),
                ElevatedButton(
                    onPressed: (){
                      final ReadBus readbus= ReadBus.fromto(_from, _to);
                      dynamic busDetails= readbus.getwithFromTo();
                      //print(busDetails);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchScreen(from: _from, to: _to, busDetails: busDetails,)));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.yellow[700]),
                    ),
                    child: Text('Search')),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
                  child: Text('Swipe screen if you have already boarded the bus',
                    style: TextStyle(fontSize: 15, color: Colors.orangeAccent),),
                ),
              ],
            ),
          ),
          Container(
            padding: new EdgeInsets.all(10.0) ,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 30, 25, 8),
                  child: Text('Find my bus',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.grey[700]),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                  child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Enter bonnet id'
                      ),
                      onChanged: (value){
                        setState(() {
                          _bonnetid = value.trim();
                        });
                      }),
                ),
                ElevatedButton(
                    onPressed: (){
                      final ReadBus readbus= ReadBus(_bonnetid);
                      dynamic busDetails= readbus.getwithBonnetid();
                      //print("Bus Details $busDetails");
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => FindScreen(bonnetid: _bonnetid, busDetails: busDetails,)));

                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.yellow[700]),
                    ),
                    child: Text('Find my bus')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





