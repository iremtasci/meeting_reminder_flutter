import 'package:flutter/material.dart';
import 'package:toplantireminder/common_widget/provider_widget.dart';
import 'package:toplantireminder/models/plan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toplantireminder/models/plan.dart';

class YMeetingFinish extends StatelessWidget {

  final db = Firestore.instance;
  final Plan plan;
  YMeetingFinish({Key key, this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Yeni Toplantı Oluştur - Öncelik'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text('Tamamlandı'),
          Text("Başlık ${plan.title}"),
          Text("Takım ${plan.takimlar}"),
          Text("Öncelik ${plan.planOncelik}"),
          Text("Başlangıç ${plan.startDate}"),
          Text("Bitiş ${plan.endDate}"),
          Text("Saat ${plan.zaman}"),
          Padding(
            padding: const EdgeInsets.all(30.0),
           
          ),
          ElevatedButton(onPressed: ()async{
            // final uid = await Provider.of(context).auth.getCurrentUID();
            //         await db.collection("userData").document(uid).collection("planlar").add(plan.toJson());
           await db.collection("yazilim").add(plan.toJson());
              
              //  'title' : plan.title,
              //  'takimlar' : plan.takimlar,
              //  'planOncelik' : plan.planOncelik,
              //  'startDate' : plan.startDate,
              //  'endDate' : plan.endDate, 
              
                     
            
            Navigator.of(context).pushNamed('/yazilim');
          }, child: Text("Kaydet")),
          
        ],),
      )
      
      
      
          
    );
  }
}