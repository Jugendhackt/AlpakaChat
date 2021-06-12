

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
        title: Text("Deine Chats"),
      ),
      body: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(20),
            child: Text("Login", style: TextStyle(fontSize: 50), textAlign: TextAlign.center),
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
                    hintText: "User",
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
                decoration: InputDecoration(
                    hintText: "Password",
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
                    hintText: "Server",
                    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    border: OutlineInputBorder()
                ),
              ),
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
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(color: Colors.white)
                          )
                      )
                  ),
                  onPressed: (){
                    Matrix.of(context).login(_serverTextController.text, _userTextController.text, _passwordTextController.text);
                    AppStateManager.of(context).setLoggedIn(true);
                  },
                )
            ),
          )
        ],
      ),
    );
  }
}
