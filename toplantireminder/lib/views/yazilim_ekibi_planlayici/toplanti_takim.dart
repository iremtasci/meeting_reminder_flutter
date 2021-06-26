import 'package:flutter/material.dart';

import 'package:toplantireminder/models/plan.dart';
import 'package:toplantireminder/views/yazilim_ekibi_planlayici/toplanti_oncelik.dart';

class YMeetingTakim extends StatelessWidget {

  final Plan plan;
  YMeetingTakim({Key key, this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _takimController = new TextEditingController();
    _takimController.text = plan.takimlar;
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
            plan.takimlar = _takimController.text;
            Navigator.push(context, MaterialPageRoute(builder: (context)=> YMeetingOncelik(plan: plan)),);
          }, child: Text("Devam"))
        ],),
      )
      
      
      
          
    );
  }
}