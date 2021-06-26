import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toplantireminder/models/toplanti.dart';
import 'package:toplantireminder/models/user.dart';
import 'package:toplantireminder/pages.dart';
import 'package:toplantireminder/services/auth_service.dart';
import 'package:toplantireminder/views/home_view.dart';
import 'package:toplantireminder/views/new_meeting/toplanti_ayrinti.dart';
import 'package:toplantireminder/views/profile_view.dart';
import 'package:toplantireminder/views/profile_view.dart';

import 'common_widget/provider_widget.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

 
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeView(),
    
    TeamPage(),
    ProfileView(),
  ];
  
  

 
  
  @override
  Widget build(BuildContext context) {
    
    
    
 
    return Scaffold(
      appBar: AppBar(
        title: Text("Toplantı Hatırlatıcı"),
        actions: <Widget>[
          
            
          
          
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: () async {
              try {
                AuthService auth = Provider.of(context).auth;
                await auth.signOut();
                print("Çıkış!");
              } catch (e) {
                print (e);
              }
            },
          ),
        
        ],
        
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.work),
              title: new Text("Toplantılar"),
            ),
            
            BottomNavigationBarItem(
              icon: new Icon(Icons.people),
              title: new Text("Takımlar"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.person),
              title: new Text("Profil"),
            )
          
          ]
      ),
    );
  }
  
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  
}