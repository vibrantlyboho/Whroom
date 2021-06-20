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

  Occupancy.plain();

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
  Future<void> upVote(String snapid){
    return _db
        .collection('loc_n_seat')
        .doc(snapid)
        .update({'voteCount': FieldValue.increment(1)})
        .then((value) => print("Upvoted"))
        .catchError((error) => print("Failed to upvote: $error"));
  }

  //delete an entry given by user
  Future<void> deleteEntryOnTap(String snapid){
    return _db
        .collection('loc_n_seat')
        .doc(snapid)
        .delete()
        .then((value) => print("Entry Deleted"))
        .catchError((error) => print("Failed to delete entry: $error"));
  }

  //delete an entry when user exits the bus
  Future<void> deleteEntryonExit(String uid){
    return _db
        .collection('loc_n_seat')
        .doc()
        .delete()
        .then((value) => print("Entry Deleted"))
        .catchError((error) => print("Failed to delete entry: $error"));
  }

}



