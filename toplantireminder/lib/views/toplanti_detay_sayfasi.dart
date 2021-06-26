import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toplantireminder/common_widget/provider_widget.dart';
import 'package:toplantireminder/models/toplanti.dart';

import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';


class DetailtoplantiView extends StatefulWidget {
  final Toplanti toplanti;

  DetailtoplantiView({Key key, @required this.toplanti}) : super(key: key);

  @override
  _DetailtoplantiViewState createState() => _DetailtoplantiViewState();
}

class _DetailtoplantiViewState extends State<DetailtoplantiView> {
 

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Toplantı Detay'),
              backgroundColor: Colors.green,
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
                
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 30,
                  ),
                  padding: const EdgeInsets.only(right: 15),
                  onPressed: () {
                    _toplantiEditModalBottomSheet(context);
                  },
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                toplantiDetails(),
               
                
                daysOutCard(),
               
                Container(
                  height: 200,
                )
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget daysOutCard() {
    return Card(
      color: Colors.amberAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("${widget.toplanti.getDaysUntiltoplanti()}", style: TextStyle(fontSize: 75)),
            Text("toplantına kalan gün sayısı", style: TextStyle(fontSize: 25))
          ],
        ),
      ),
    );
  }

  Widget toplantiDetails() {
    return Card(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.toplanti.title,
                  style: TextStyle(fontSize: 30, color: Colors.green[900]),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Text(
                    "${DateFormat('MM/dd/yyyy').format(widget.toplanti.startDate).toString()} - ${DateFormat('MM/dd/yyyy').format(widget.toplanti.endDate).toString()}"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget totalBudgetCard() {
    return Card(
      color: Colors.blue,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Daily Budget",
                    style: TextStyle(fontSize: 15, color: Colors.white)),
              ],
            ),
          ),
         
        ],
      ),
    );
  }



  void _toplantiEditModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Edit toplanti"),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.orange,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      widget.toplanti.title,
                      style: TextStyle(fontSize: 30, color: Colors.green[900]),
                    ),
                  ],
                ),
               
               
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Delete'),
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () async {
                        await deletetoplanti(context);
                        Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future updatetoplanti(context) async {
    var uid = await Provider.of(context).auth.getCurrentUID();
    final doc = Firestore.instance
        .collection('userData')
        .document(uid)
        .collection("toplantilar")
        .document(widget.toplanti.documentId);

    return await doc.setData(widget.toplanti.toJson());
  }

  Future deletetoplanti(context) async {
    var uid = await Provider.of(context).auth.getCurrentUID();
    final doc = Firestore.instance
       
        .collection("toplantilar")
        .document(widget.toplanti.documentId);

    return await doc.delete();
  }
}