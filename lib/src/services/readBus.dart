import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whroomapp1/src/models/bus.dart';


class ReadBus{
  FirebaseFirestore _db= FirebaseFirestore.instance;
  String bonnetid= '';
  String from= '';
  String to= '';

  ReadBus(String bid){
    bonnetid = bid;
  }

  ReadBus.fromto(String from, String to){
    this.from= from;
    this.to=to;
  }


  //Get entries
  Future<QuerySnapshot> getwithBonnetid(){
    return _db
        .collection('bus')
        .where("bonnetid", isEqualTo: bonnetid)
        .where("isRunning", isEqualTo: true)
        .get();
  }

  Future<QuerySnapshot> getwithFromTo(){
    return _db
        .collection('bus')
        .where('from', isEqualTo: from)
        .where('to', isEqualTo: to)
        .where("isRunning", isEqualTo: true)
        .get();
  }


}



