

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'newaccount.dart';

class Welcome extends StatefulWidget{


  @override
  State<StatefulWidget> createState() => _welcomestate();
}

class _welcomestate extends State<Welcome>{
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Color(0xdcb1f6cf),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/logo.png",
            height: 50,
            width: 50,
          ),
          SizedBox(width: 20,),
          Text(
            "Wilkommen im Alpaka Chat!",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    ),
    body: Container(
      decoration: BoxDecoration(
        color: Color(0xbae3fff0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: (MediaQuery.of(context).size.height / 3),
            width: MediaQuery.of(context).size.width,
            child: TextButton(
                style: ButtonStyle(

                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Loginwidget()),
                ),
                child: Text("Einloggen")
            ),
          ),
          Divider(height: 4,),
          Container(
            height: (MediaQuery.of(context).size.height / 3),
            width: MediaQuery.of(context).size.width,

            child: TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => registerwidget()),
                ),
                child: Text("neuen Account anlegen")
            ),
          )
        ],
      ),
    ),
  );
}