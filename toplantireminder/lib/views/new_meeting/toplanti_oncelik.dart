import 'package:flutter/material.dart';
import 'package:toplantireminder/models/toplanti.dart';
import 'package:toplantireminder/views/new_meeting/toplanti_kayit.dart';
import 'package:toplantireminder/views/new_meeting/toplanti_tarih.dart';

class NewMeetingOncelik extends StatelessWidget {

  final Toplanti toplanti;
  NewMeetingOncelik({Key key, this.toplanti}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _oncelikController = new TextEditingController();
    _oncelikController.text = toplanti.toplantiOncelik;
    return Scaffold(
      appBar: AppBar(title: Text('Yeni Toplantı Oluştur - Öncelik'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text('Toplantı Öncelik'),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
              controller: _oncelikController,
              autofocus: true,
            ),
          ),
          ElevatedButton(onPressed: (){
            toplanti.toplantiOncelik = _oncelikController.text;
            Navigator.push(context, MaterialPageRoute(builder: (context)=> NewMeetingFinish(toplanti: toplanti)),);
          }, child: Text("Devam"))
        ],),
      )
      
      
      
          
    );
  }
}