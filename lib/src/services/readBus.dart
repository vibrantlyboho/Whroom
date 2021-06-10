import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whroomapp1/src/models/bus.dart';


class ReadBus{
  FirebaseFirestore _db= FirebaseFirestore.instance;
  String bonnetid= '';
  ReadBus(String bid){
    bonnetid = bid;
  }

  //Get entries
  Future<Null> getwithBonnetid(){
    return _db
        .collection('bus')
        .where("bonnetid", isEqualTo: bonnetid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["bonnetid"]);
        print(doc["stops"]);
      });
    });

  }

}











/*

class ReadBus extends StatefulWidget {
  const ReadBus({Key? key}) : super(key: key);

  @override
  _ReadBusState createState() => _ReadBusState();
}

class _ReadBusState extends State<ReadBus> {

  String bonnetid='';
  String from='';
  String to='';
  bool isRunning= true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Check if search condition true'),
    );
  }

}
*/



/*class ReadBus extends StatelessWidget {
  const ReadBus({Key? key}) : super(key: key);

  Widget _buildListItem(BuildContext context ){
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Text('bus name'),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.orange,
            ),
            padding: const EdgeInsets.all(100),
            child: Text('5'),
          ),
        ],
      ),
      onTap: (){},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
       child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemExtent: 10,
            itemCount: 5,
            itemBuilder: (context, index) => _buildListItem(context)
        )
    );

  }
}
*/