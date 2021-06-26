import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:toplantireminder/common_widget/custom_dialog.dart';

class FirstView extends StatelessWidget {
  final primaryColor = const Color(0xFF80CBC4);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        color: primaryColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: _height * 0.10),
                Text(
                  "Hoş Geldiniz",
                  style: TextStyle(fontSize: 44, color: Colors.white),
                ),
                SizedBox(height: _height * 0.10),
                AutoSizeText(
                  "Toplantılarını Planlamaya Başlayalım",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: _height * 0.15),
                ElevatedButton(
                 
                    
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                    child: Text(
                      "Başlayalım",
                      style: TextStyle(
                        
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomDialog(
                        title: "Yeni Hesap Oluştur",
                        description:
                            "Bilgi İşlem Birimi için Özel Olarak Hazırlanmış Uygulamamıza Hoş Geldiniz",
                        primaryButtonText: "Hesap Oluşturalım",
                        primaryButtonRoute: "/signUp",
                        
                        secondaryButtonRoute: "/home",
                      ),
                    );
                  },
                ),
                SizedBox(height: _height * 0.05),
                ElevatedButton(
                  child: Text(
                    "Giriş Yap",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/signIn');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}