import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BusCardInfo extends StatelessWidget {
  const BusCardInfo({Key? key, required QueryDocumentSnapshot queryDocumentSnapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('BusCardInfo');
  }
}
