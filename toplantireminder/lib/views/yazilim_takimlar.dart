import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toplantireminder/common_widget/provider_widget.dart';
import 'package:toplantireminder/models/plan.dart';
import 'package:toplantireminder/models/toplanti.dart';
import 'package:toplantireminder/views/toplanti_detay_sayfasi.dart';


class YazilimPlanlayici extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Yazılım Ekibi Planları'),
          ),
    body: new Center(
                child: new Column(
                  children: <Widget>[
        new Expanded(child:
            new StreamBuilder(
          stream: getUsersplansStreamSnapshots(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text("Loading...");
            return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildplanCard(context, snapshot.data.documents[index]));
          }
      ),
    ),
    ElevatedButton(onPressed: () {
      Navigator.of(context).pushNamed('/yazilimPlan');
      
    }, child: Text("Ekibin İçin Yeni Plan Oluştur"))]))));
  }

  Stream<QuerySnapshot> getUsersplansStreamSnapshots(
      BuildContext context) async* {
    final uid = await Provider
        .of(context)
        .auth
        .getCurrentUID();
    yield* Firestore.instance.collection('yazilim').snapshots();
  }

  Widget buildplanCard(BuildContext context, DocumentSnapshot document) {
    final plan = Plan.fromSnapshot(document);
   
    
   
    return new Container(
      
      child: Card(
        
        child: InkWell(
          
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[

               
                
                Padding(
                 
  
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    
                    Text(plan.title, style: new TextStyle(fontSize: 30.0),), 
                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 10.0),
                  child: Row(children: <Widget>[
                    Text(
                        "${DateFormat('dd/MM/yyyy')
                            .format(plan.startDate)
                            .toString()} - ${DateFormat('dd/MM/yyyy').format(
                            plan.endDate).toString()}"),
                    Spacer(),
                  ]),
                ),
                Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 10.0),
                child: Row(children: <Widget>[
                 
                  Text(plan.zaman, style: new TextStyle(fontSize: 20.0),),
                  Spacer(),
                ]),
              ),
               
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 10.0),
                child: Row(children: <Widget>[
                  Text('Katılacak Ekip: '), 
                  Text(plan.takimlar),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 10.0),
                child: Row(children: <Widget>[
                  Text('Öncelik Durumu: '),
                  Text(plan.planOncelik),
                  Spacer(),
                  
                ]),
              ),
               
              ],
            ),
          ),
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => DetailplanView(plan: plan)),
          //   );
          // },
          
        ),
      ),
    );
  }
}

