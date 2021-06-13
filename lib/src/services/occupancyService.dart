import 'package:cloud_firestore/cloud_firestore.dart';


class Occupancy{
  FirebaseFirestore _db= FirebaseFirestore.instance;
  late String bonnetid;
  late String option;
  late int voteCount;
  late String uid;
  late String username;

  Occupancy(String bid){
    bonnetid= bid;
  }

  Future<QuerySnapshot> getOccdetails(){
    return _db
        .collection('loc_n_seat')
        .orderBy('voteCount', descending: true)
        .where("bonnetid", isEqualTo: bonnetid)
        .get();
  }

  Future<void> addOccdetails(){
    return _db
        .collection('loc_n_seat')
        .add({
          'bonnetid': bonnetid,
          'option': option,
          'voteCount': voteCount,
          'uid': uid,
            'username': username
        })
        .then((value) => print("Location Added"))
        .catchError((error) => print("Failed to add location: $error"));
  }


}



