import 'package:flutter/material.dart';


import 'package:toplantireminder/models/plan.dart';
import 'package:toplantireminder/views/yazilim_ekibi_planlayici/toplanti_kayit.dart';

class YMeetingOncelik extends StatelessWidget {

  final Plan plan;
  YMeetingOncelik({Key key, this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _oncelikController = new TextEditingController();
    _oncelikController.text = plan.planOncelik;
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
            plan.planOncelik = _oncelikController.text;
            Navigator.push(context, MaterialPageRoute(builder: (context)=> YMeetingFinish(plan: plan)),);
          }, child: Text("Devam"))
        ],),
      )
      
      
      
          
    );
  }
}