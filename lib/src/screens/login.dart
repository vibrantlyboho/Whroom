import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whroomapp1/src/screens/home.dart';
import 'package:whroomapp1/src/services/addUser.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email='', _password='', _username='';
  final auth= FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.yellow[700],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Username'
              ),
              onChanged: (value){
                setState(() {
                  _username = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email'
              ),
              onChanged: (value){
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password'
              ),
              onChanged: (value){
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //Sign In Button
              ElevatedButton(
                  onPressed: () async{
                    try{
                      UserCredential currentuser= await auth.signInWithEmailAndPassword(email: _email, password: _password);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
                    } on FirebaseAuthException catch (e){
                      print('FAILED with error code: ${e.code}');
                      print(e.message);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.yellow[700]),
                  ),
                  child: Text('Sign in')),
              //Sign Up Button
              ElevatedButton(
                  onPressed: () async {
                    try{
                      UserCredential currentuser= await auth.createUserWithEmailAndPassword(email: _email, password: _password);
                      //getting user uid from firebaseauth, storing it in uid and creating a new user in user collection
                      String _uid= currentuser.user!.uid;
                      AddUser user= new AddUser(_username, _email, _password, _uid);
                      user.addUser();
                      //
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
                    } on FirebaseAuthException catch(e){
                      print('FAILED with error code: ${e.code}');
                      print(e.message);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.yellow[700]),
                  ),
                  child: Text('Sign Up')),
            ],
          )
        ],
      ),
    );
  }
}

