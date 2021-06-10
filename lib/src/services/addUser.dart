import 'package:flutter/material.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser{
  final String username;
  final String email;
  final String password;
  final String uid;

  AddUser(this.username, this.email, this.password, this.uid);

    // Create a CollectionReference called user that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('user');


    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
        'uid': uid,
        'username': username, // John Doe
        'email': email,
        })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

}

