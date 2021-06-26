import 'package:flutter/material.dart';
import 'package:toplantireminder/models/toplanti.dart';
import 'package:toplantireminder/views/new_meeting/toplanti_oncelik.dart';
import 'package:toplantireminder/views/new_meeting/toplanti_tarih.dart';

class NewMeetingTakim extends StatelessWidget {

  final Toplanti toplanti;
  NewMeetingTakim({Key key, this.toplanti}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _takimController = new TextEditingController();
    _takimController.text = toplanti.takimlar;
    return Scaffold(
      appBar: AppBar(title: Text('Yeni Toplantı Oluştur - Takım'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text('Toplantı Takım'),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
              controller: _takimController,
              autofocus: true,
            ),
          ),
          ElevatedButton(onPressed: (){
            toplanti.takimlar = _takimController.text;
            Navigator.push(context, MaterialPageRoute(builder: (context)=> NewMeetingOncelik(toplanti: toplanti)),);
          }, child: Text("Devam"))
        ],),
      )
      
      
      
          
    );
  }
}