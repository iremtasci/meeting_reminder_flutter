import 'package:flutter/material.dart';
import 'package:toplantireminder/models/toplanti.dart';
import 'package:toplantireminder/views/new_meeting/toplanti_tarih.dart';

class NewMeetingBaslik extends StatelessWidget {

  final Toplanti toplanti;
  NewMeetingBaslik({Key key, this.toplanti}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = toplanti.title;
    return Scaffold(
      appBar: AppBar(title: Text('Yeni Toplantı Oluştur - Başlık'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text('Toplantı Başlık'),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
              controller: _titleController,
              autofocus: true,
            ),
          ),
          ElevatedButton(onPressed: (){
            toplanti.title = _titleController.text;
            Navigator.push(context, MaterialPageRoute(builder: (context)=> NewMeetingTarihView(toplanti: toplanti)),);
          }, child: Text("Devam"))
        ],),
      )
      
      
      
          
    );
  }
}