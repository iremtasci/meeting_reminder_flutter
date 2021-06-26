

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toplantireminder/home_widget.dart';
import 'package:toplantireminder/models/plan.dart';
import 'package:toplantireminder/views/first_view.dart';

import 'package:toplantireminder/services/auth_service.dart';
import 'package:toplantireminder/views/new_meeting/toplanti_ayrinti.dart';
import 'package:toplantireminder/views/sign_up_view.dart';
import 'package:toplantireminder/views/yazilim_ekibi_planlayici/plan_ayrinti.dart';
import 'package:toplantireminder/views/yazilim_takimlar.dart';

import 'common_widget/provider_widget.dart';
import 'models/toplanti.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final newToplanti = new Toplanti(null,null,null, null, null, null, null);
    final newPlan = new Plan(null,null,null, null, null, null, null);
 
    return Provider(
      auth: AuthService(),
      db: Firestore.instance,
      child: MaterialApp(
        title: 'Hatırlatıcı',
        theme: ThemeData(
          
          primarySwatch: Colors.teal,
        ),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
           '/signUp': (BuildContext context) => SignUpView(authFormType: AuthFormType.signUp),
          '/signIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.signIn),
          '/home': (BuildContext context) => HomeController(),
          '/toplanti': (BuildContext context) => NewMeetingBaslik(toplanti: newToplanti),
          '/yazilimPlan': (BuildContext context) => YMeetingBaslik(plan: newPlan),
          '/yazilim': (BuildContext context) => YazilimPlanlayici(),
         
        }
      ),
    );
  }
}

class HomeController extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(stream: auth.onAuthStateChanged,
    builder: (context, AsyncSnapshot<String> snapshot){
      if(snapshot.connectionState == ConnectionState.active){
        final bool signedIn = snapshot.hasData;
        return signedIn ? Home() : FirstView();
      }
      return CircularProgressIndicator();
    }
    
    );
  }
}



