import 'package:flutter/material.dart';
import 'package:toplantireminder/models/plan.dart';
import 'package:toplantireminder/models/toplanti.dart';

import 'package:toplantireminder/views/yazilim_ekibi_planlayici/toplanti_tarih.dart';

class YMeetingBaslik extends StatelessWidget {

  final Plan plan;
  YMeetingBaslik({Key key, this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = plan.title;
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
            plan.title = _titleController.text;
            Navigator.push(context, MaterialPageRoute(builder: (context)=> YMeetingTarihView(plan: plan)),);
          }, child: Text("Devam"))
        ],),
      )
      
      
      
          
    );
  }
}