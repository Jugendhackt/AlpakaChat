

import 'package:flutter/material.dart';

class Loginwidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _loginwidget();
}

class _loginwidget extends State<Loginwidget>{
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text("Login", style: TextStyle(fontSize: 50),),
        Text("Email:", style: TextStyle(fontSize: 20),),
        TextField(

        )
      ],
    );
  }
}
