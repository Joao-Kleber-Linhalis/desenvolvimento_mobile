import 'dart:ffi';

import "package:flutter/material.dart";
import 'controls/control_opening_screen.dart';

class OpeningScreen extends StatefulWidget {

  @override
  State<OpeningScreen> createState() => _OpeningScreenState();
}



class _OpeningScreenState extends State<OpeningScreen> {
  ControlOpeningScreen _control = ControlOpeningScreen();

  @override
  void initState(){
    super.initState();
    _control.runApp(context);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.green[200],
      alignment: Alignment.center,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset("assets/icon/icon_opening_screen.png", fit: BoxFit.contain),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 100),
            child: Text(
              "Pig Pay",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                // Sem linha abaixo do texto
                decoration: TextDecoration.none,
              ),

            ),
          ),
          Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}