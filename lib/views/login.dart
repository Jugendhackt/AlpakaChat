

import 'dart:html';

import 'package:alpaka_chat/views/serverview.dart';
import 'package:alpaka_chat/views/appstate.dart';
import 'package:flutter/material.dart';

import '../matrix.dart';

class Loginwidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _loginwidget();
}

class _loginwidget extends State<Loginwidget>{

  TextEditingController _serverTextController = new TextEditingController();
  TextEditingController _userTextController = new TextEditingController();
  TextEditingController _passwordTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aplaka Chat"),
        centerTitle: true
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Text(
              "Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w400,
                ),
                ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            child: SizedBox(
              width: 300,
              child: TextField(
                controller: _userTextController,
                decoration: InputDecoration(
                    hintText: "Benutzername",
                    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    border: OutlineInputBorder()
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            child: SizedBox(
              width: 300,
              child: TextField(
                controller: _passwordTextController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Passwort",
                    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    border: OutlineInputBorder()
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            child: SizedBox(
              width: 300,
              child: TextField(
                controller: _serverTextController,
                decoration: InputDecoration(
                    hintText: "Serveradresse",
                    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    border: OutlineInputBorder()
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            child: OutlinedButton(
              onPressed: () => serverloader(context, _serverTextController),
              child: Text("Serverauswahl"),
              ),
            ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(20),
            child: SizedBox(
                width: 200,
                height: 50,
                child :OutlinedButton(
                  child: Text("Submit", style: TextStyle(fontSize: 20),),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.white)
                          )
                      )
                  ),
                  onPressed: (){
                    Matrix.of(context).login(_serverTextController.text, _userTextController.text, _passwordTextController.text).then((value) {
                      if (value) {
                        AppStateManager.of(context).setLoggedIn(true);
                      }
                    });
                  },
                )
            ),
          )
        ],
      ),
    );
  }
}
