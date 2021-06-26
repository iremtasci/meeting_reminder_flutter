import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toplantireminder/common_widget/provider_widget.dart';
import 'package:toplantireminder/models/toplanti.dart';
import 'package:toplantireminder/views/toplanti_detay_sayfasi.dart';


class HomeView extends StatelessWidget {

 

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: getUserstoplantisStreamSnapshots(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text("Loading...");
            return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildtoplantiCard(context, snapshot.data.documents[index]));
          }
      ),
    );
  }

  Stream<QuerySnapshot> getUserstoplantisStreamSnapshots(
      BuildContext context) async* {
    final uid = await Provider
        .of(context)
        .auth
        .getCurrentUID();
    yield* Firestore.instance.collection('toplantilar').snapshots();
  }

  Widget buildtoplantiCard(BuildContext context, DocumentSnapshot document) {
    final toplanti = Toplanti.fromSnapshot(document);
    final toplantiType = toplanti.types();
   
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
                    
                    Text(toplanti.title, style: new TextStyle(fontSize: 30.0),), 
                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 10.0),
                  child: Row(children: <Widget>[
                    Text(
                        "${DateFormat('dd/MM/yyyy')
                            .format(toplanti.startDate)
                            .toString()} - ${DateFormat('dd/MM/yyyy').format(
                            toplanti.endDate).toString()}"),
                    Spacer(),
                  ]),
                ),
                Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 10.0),
                child: Row(children: <Widget>[
                 
                  Text(toplanti.zaman, style: new TextStyle(fontSize: 20.0),),
                  Spacer(),
                ]),
              ),
               
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 10.0),
                child: Row(children: <Widget>[
                  Text('Katılacak Ekip: '), 
                  Text(toplanti.takimlar),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 10.0),
                child: Row(children: <Widget>[
                  Text('Öncelik Durumu: '),
                  Text(toplanti.toplantiOncelik),
                  Spacer(),
                  
                ]),
              ),
               
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailtoplantiView(toplanti: toplanti)),
            );
          },
        ),
      ),
    );
  }
}



/*

class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: getUserstoplantisStreamSnapshots(context),
        builder: (context, snapshot) {
          if(!snapshot.hasData) return const Text("Loading...");
          return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildtoplantiCard(context, snapshot.data.documents[index]));
        }
      ),
    );
  }

  Stream<QuerySnapshot> getUserstoplantisStreamSnapshots(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('toplantilar').snapshots();
  }

  Widget buildtoplantiCard(BuildContext context, DocumentSnapshot document) {
     final toplanti = Toplanti.fromSnapshot(document);
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
                  Text(toplanti.title, style: new TextStyle(fontSize: 30.0, color: Colors.blue)),
                  Spacer(),
                ]),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 10.0),
                  child: Row(children: <Widget>[
                    Text(
                        "${DateFormat('dd/MM/yyyy')
                            .format(toplanti.startDate)
                            .toString()} - ${DateFormat('dd/MM/yyyy').format(
                            toplanti.endDate).toString()}"),
                    Spacer(),
                  ]),
                ),
                Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 10.0),
                child: Row(children: <Widget>[
                 
                  Text(toplanti.zaman, style: new TextStyle(fontSize: 20.0),),
                  Spacer(),
                ]),
              ),
               
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 10.0),
                child: Row(children: <Widget>[
                  Text('Katılacak Ekip: '), 
                  Text(toplanti.takimlar),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 10.0),
                child: Row(children: <Widget>[
                  Text('Öncelik Durumu: '),
                  Text(toplanti.toplantiOncelik),
                  Spacer(),
                  
                ]),
              ),
              
              
              
            ],
            
          ),
          
        ),
        onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailtoplantiView(toplanti: toplanti)),
            );
          },
        
        
        
        ),
      ),
      
    );
    
  }
}
*/

 /*
  Widget buildtoplantiCard(BuildContext context, DocumentSnapshot document) {
    final toplanti = toplanti.fromSnapshot(document);
    final toplantiType = toplanti.types();

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
                    Text(toplanti.title, style: GoogleFonts.seymourOne(fontSize: 20.0),),
                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                  child: Row(children: <Widget>[
                    Text(
                        "${DateFormat('dd/MM/yyyy')
                            .format(toplanti.startDate)
                            .toString()} - ${DateFormat('dd/MM/yyyy').format(
                            toplanti.endDate).toString()}"),
                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    children: <Widget>[
                      Text("\$${(toplanti.budget == null) ? "n/a" : toplanti.budget
                          .toStringAsFixed(2)}",
                        style: new TextStyle(fontSize: 35.0),),
                      Spacer(),
                      (toplantiType.containsKey(toplanti.travelType)) ? toplantiType[toplanti
                          .travelType] : toplantiType["other"],
                    ],
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailtoplantiView(toplanti: toplanti)),
            );
          },
        ),
      ),
    );
  }
}

 */