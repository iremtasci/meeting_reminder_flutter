import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toplantireminder/models/local_not.dart';

class Plan {
  String title;
  DateTime startDate;
  DateTime endDate;
  String zaman;
  String takimlar;
  String planOncelik;
  String documentId;   //güncellemeler falan filan
  String planType;

  Plan(
      this.title,
      this.startDate,
      this.endDate,
      this.zaman,
      this.takimlar,
      this.planOncelik,
      this.planType
      );

  Map<String, dynamic> toJson() => {
    'title': title,
    'startDate': startDate,
    'endDate': endDate,
    'zaman' : zaman.toString(),
    'takimlar': takimlar,
    'planOncelik': planOncelik,
    
  };

  Plan.fromSnapshot(DocumentSnapshot snapshot) :
      title = snapshot['title'],
      startDate = snapshot['startDate'].toDate(),
      endDate = snapshot['endDate'].toDate(),
      zaman = snapshot['zaman'].toString(),
      takimlar = snapshot['takimlar'],
      planOncelik = snapshot['planOncelik'],
      documentId = snapshot.documentID;

  Map<String, Icon> types() => {
    "car": Icon(Icons.directions_car, size: 50),
    "bus": Icon(Icons.directions_bus, size: 50),
    "train": Icon(Icons.train, size: 50),
    "plane": Icon(Icons.airplanemode_active, size: 50),
    "ship": Icon(Icons.directions_boat, size: 50),
    "other": Icon(Icons.directions, size: 50),
  };
   int getTotalplanDays() {
    return endDate.difference(startDate).inDays;
  }

  int getDaysUntilplan() {
    int diff = startDate.difference(DateTime.now()).inDays;
    if (diff < 0) {
      diff = 0;
     

    }
    return diff;
  }

}