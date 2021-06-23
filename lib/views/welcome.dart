

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Welcome extends StatefulWidget{


  @override
  State<StatefulWidget> createState() => _welcomestate();
}

class _welcomestate extends State<Welcome>{
  @override
  Widget build(BuildContext context) => Row(
    children: [
      TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Loginwidget()),
          ),
          child: Text("Einloggen")
      ),
      TextButton(
          onPressed: (){},
          child: Text("neuen Account anlegen")
      ),
    ],
  );
}