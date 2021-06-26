import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  //kendi buton widgetımı oluşturdum
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final double radius;
  final double yukseklik;
  final Widget buttonIcon;
  final VoidCallback onPressed;

  const SocialLoginButton(
      {Key key,
      @required this.buttonText,
      this.buttonColor,
      this.textColor: Colors.white,
      this.radius: 20, //eğer kullanıcı herhangi bir değer vermezse 20 al,
      this.yukseklik: 40,
      this.buttonIcon,
      @required this.onPressed})
      : assert(buttonText != null, onPressed != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: yukseklik,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                primary: buttonColor, //arkaplan
                onPrimary: Colors.white, //ön plan
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(radius)))),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (buttonIcon != null) ...[
                    buttonIcon,
                    Text(
                      buttonText,
                      style: TextStyle(color: textColor),
                    ),
                    Opacity(opacity: 0, child: buttonIcon)
                  ],
                  if (buttonIcon == null) ...[
                    Container(),
                    Text(
                      buttonText,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: textColor),
                    )
                  ]
                ])),
      ),
    );
  }
}

//eski yöntem
/*
buttonIcon != null ? buttonIcon : Container(),
                Text(
                  buttonText,
                  style: TextStyle(color: textColor),
                ),
                buttonIcon != null
                    ? Opacity(opacity: 0, child: buttonIcon)
                    : Container(),
*/
