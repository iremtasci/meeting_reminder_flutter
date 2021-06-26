import 'package:flutter/material.dart';


import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'dart:async';
import 'package:time_range_picker/time_range_picker.dart' as TimeRangePicker;
import 'package:toplantireminder/models/plan.dart';
import 'package:toplantireminder/views/yazilim_ekibi_planlayici/toplanti_takim.dart';

class YMeetingTarihView extends StatefulWidget {

  final Plan plan;
  YMeetingTarihView({Key key, this.plan}) : super(key: key);

  @override
  _YMeetingTarihViewState createState() => _YMeetingTarihViewState();
}

class _YMeetingTarihViewState extends State<YMeetingTarihView> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));
  TimeOfDay time;

  String getText(){
    if(time == null) {
      return 'Zamanı Seç';
    }
    else{
      final hours = time.hour.toString().padLeft(2,'0');
      final minutes = time.minute.toString().padLeft(2,'0');
      return '$hours: $minutes';
    }
  }

  Future displayDateRangePicker(BuildContext context) async{
     final List<DateTime> picked = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: _startDate,
        initialLastDate: _endDate,
        firstDate: new DateTime(DateTime.now().year - 50),
        lastDate: new DateTime(DateTime.now().year + 50));
    if (picked != null && picked.length == 2) {
      setState(() {
        _startDate = picked[0];
        _endDate = picked[1];
      });
    }
  }

  Future displayTimeRangePicker(BuildContext context) async{
     final initialTime = TimeOfDay(hour: 9, minute: 0);
     final newTime = await showTimePicker(context: context, initialTime: time ?? initialTime);
    
      if(newTime == null) return;

      setState(() {
        time = newTime;
      });
  
  }

 
 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text('Yeni Toplantı Oluştur - Tarih'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(child: Text("Toplantı Tarihi"),
              onPressed: () async {
                await displayDateRangePicker(context);},),
            ElevatedButton(child: Text("Toplantı Zamanı"),
              onPressed: () async {
                await displayTimeRangePicker(context);},),
          Row(
            children: [
              
             
            ],
          ),
          
         
          ElevatedButton(onPressed: (){
            widget.plan.startDate = _startDate;
            widget.plan.endDate = _endDate;
            widget.plan.zaman = getText();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> YMeetingTakim(plan: widget.plan)),);
          }, child: Text("Devam"))
        ],),
      )
      
      
      
          
    );
  }
}