import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toplantireminder/common_widget/provider_widget.dart';

import 'package:intl/intl.dart';
import 'package:toplantireminder/models/user.dart';


import 'new_meeting/toplanti_ayrinti.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  User user = User("");
  bool _isAdmin = false;
  
  TextEditingController _userCountryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: Provider.of(context).auth.getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayUserInformation(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget displayUserInformation(context, snapshot) {
    final authData = snapshot.data;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "İsim: ${authData.displayName ?? 'Anonymous'}",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Email: ${authData.email ?? 'Anonymous'}",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Hesap Oluşturma Tarihi: ${DateFormat('MM/dd/yyyy').format(authData.metadata.creationTime)}",
            style: TextStyle(fontSize: 20),
          ),
        ),
        FutureBuilder(
          future: _getProfileData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              _userCountryController.text = user.takim;
              _isAdmin = user.admin ?? false;
            }
            return Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Takım: ${_userCountryController.text}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  adminFeature(),
                  teamFeature() ,
                ],
              ),
            );
          }
        ),
        showSignOut(context, authData.isAnonymous),
        ElevatedButton(
          child: Text("Takımını Güncelle"),
          onPressed: () {
            _userEditBottomSheet(context);
          },
        )
      ],
    );
  }
 


  _getProfileData() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Provider.of(context)
        .db
        .collection('userData')
        .document(uid)
        .get().then((result) {
          user.takim = result.data['takim'];
          user.admin = result.data['admin'];
    });
  }

  Widget showSignOut(context, bool isAnonymous) {
    if (isAnonymous == true) {
      return ElevatedButton(
        child: Text("Gir"),
        onPressed: () {
          Navigator.of(context).pushNamed('/convertUser');
        },
      );
    } else {
      return ElevatedButton(
        child: Text("Çıkış Yap"),
        onPressed: () async {
          try {
            await Provider.of(context).auth.signOut();
          } catch (e) {
            print(e);
          }
        },
      );
    }
  }

  Widget adminFeature() {
    if(_isAdmin == true) {
      return ElevatedButton(
        child: Text("Sen bir Adminsin! Yeni Toplantı Oluştur"),
          onPressed: () {
          Navigator.of(context).pushNamed('/toplanti');
        },
      );
    } else {
      return Container();
    }
  }

  Widget teamFeature() {
    if(user.takim == 'sistem') {
      return ElevatedButton(
        child: Text("Sistem Takımın için Yeni Plan Oluştur"),
          onPressed: () {
          Navigator.of(context).pushNamed('/toplanti');
        },
      );
    } else if(user.takim == 'yazilim'){
      return ElevatedButton(
        child: Text("Yazılım Takımın için Yeni Plan Oluştur"),
          onPressed: () {
          Navigator.of(context).pushNamed('/yazilim');
        },
      );

      

    } 
    else {
      return Container();
    }
  }

  void _userEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .60,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 15.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Takımını Güncelle"),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      color: Colors.orange,
                      iconSize: 25,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: TextField(
                          controller: _userCountryController,
                          decoration: InputDecoration(
                            helperText: "Takım",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      child: Text('Kaydet'),
                      
                      onPressed: () async {
                        user.takim = _userCountryController.text;
                        setState(() {
                          _userCountryController.text = user.takim;
                        });
                        final uid =
                            await Provider.of(context).auth.getCurrentUID();
                        await Provider.of(context)
                            .db
                            .collection('userData')
                            .document(uid)
                            .setData(user.toJson());
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}