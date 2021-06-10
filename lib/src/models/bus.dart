import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Bus{
  final String bonnetid;
  final bool isRunning;
  final List stops;

  Bus({required this.bonnetid, required this.isRunning, required this.stops});

  factory Bus.fromMap(Map data){
    return Bus(
      bonnetid: data['bonnetid'],
      isRunning: data['isRunning'],
      stops: data['stops']
    );
  }
}