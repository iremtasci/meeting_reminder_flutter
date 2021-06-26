import 'package:flutter/material.dart';
import 'package:toplantireminder/models/toplanti.dart';
import 'package:toplantireminder/views/new_meeting/toplanti_takim.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'dart:async';
import 'package:time_range_picker/time_range_picker.dart' as TimeRangePicker;

class NewMeetingTarihView extends StatefulWidget {

  final Toplanti toplanti;
  NewMeetingTarihView({Key key, this.toplanti}) : super(key: key);

  @override
  _NewMeetingTarihViewState createState() => _NewMeetingTarihViewState();
}

class _NewMeetingTarihViewState extends State<NewMeetingTarihView> {
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
            widget.toplanti.startDate = _startDate;
            widget.toplanti.endDate = _endDate;
            widget.toplanti.zaman = getText();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> NewMeetingTakim(toplanti: widget.toplanti)),);
          }, child: Text("Devam"))
        ],),
      )
      
      
      
          
    );
  }
}