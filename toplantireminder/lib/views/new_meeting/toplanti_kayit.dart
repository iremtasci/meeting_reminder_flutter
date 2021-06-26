import 'package:flutter/material.dart';
import 'package:toplantireminder/common_widget/provider_widget.dart';
import 'package:toplantireminder/models/toplanti.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMeetingFinish extends StatelessWidget {

  final db = Firestore.instance;
  final Toplanti toplanti;
  NewMeetingFinish({Key key, this.toplanti}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Yeni Toplantı Oluştur - Öncelik'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text('Tamamlandı'),
          Text("Başlık ${toplanti.title}"),
          Text("Takım ${toplanti.takimlar}"),
          Text("Öncelik ${toplanti.toplantiOncelik}"),
          Text("Başlangıç ${toplanti.startDate}"),
          Text("Bitiş ${toplanti.endDate}"),
          Text("Saat ${toplanti.zaman}"),
          Padding(
            padding: const EdgeInsets.all(30.0),
           
          ),
          ElevatedButton(onPressed: ()async{
            // final uid = await Provider.of(context).auth.getCurrentUID();
            //         await db.collection("userData").document(uid).collection("toplantilar").add(toplanti.toJson());
           await db.collection("toplantilar").add(toplanti.toJson());
              
              //  'title' : toplanti.title,
              //  'takimlar' : toplanti.takimlar,
              //  'toplantiOncelik' : toplanti.toplantiOncelik,
              //  'startDate' : toplanti.startDate,
              //  'endDate' : toplanti.endDate, 
              
                     
            
            Navigator.of(context).pushNamed('/home');
          }, child: Text("Kaydet")),
          
        ],),
      )
      
      
      
          
    );
  }
}