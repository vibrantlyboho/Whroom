import 'package:cloud_firestore/cloud_firestore.dart';


class Occupancy{
  FirebaseFirestore _db= FirebaseFirestore.instance;
  late String bonnetid;
  late String option;
  late int voteCount=0;
  late String uid;

  Occupancy(String bid){
    bonnetid= bid;
  }

  Future<QuerySnapshot> getOccdetails(){
    return _db
        .collection('loc_n_seat')
        .where("bonnetid", isEqualTo: bonnetid)
        .get();
  }

  Future<void> addOccdetails(String bonnetid, String option, int voteCount, String uid){
    return _db
        .collection('loc_n_seat')
        .add({
          'bonnetid': bonnetid,
          'option': option,
          'voteCount': voteCount,
          'uid': uid,
        })
        .then((value) => print("Occupancy Details Added"))
        .catchError((error) => print("Failed to add occupancy details: $error"));
  }

  //function to update votecount for the tapped card

}



