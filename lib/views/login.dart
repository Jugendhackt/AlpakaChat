import 'package:alpaka_chat/views/serverview.dart';
import 'package:alpaka_chat/views/newaccount.dart';
import 'package:alpaka_chat/views/appstate.dart';
import 'package:flutter/material.dart';

import '../matrix.dart';

class Loginwidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _loginwidget();
}

class _loginwidget extends State<Loginwidget> {
  TextEditingController _serverTextController = new TextEditingController();
  TextEditingController _userTextController = new TextEditingController();
  TextEditingController _passwordTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
          title: Text("Alpaka Chat"),
          centerTitle: true
        ),
        body: Container(
            decoration: BoxDecoration(
              color: Color(0xbae3fff0),
            ),
          child: ListView(
            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  //color: Colors.greenAccent[100],
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/logo.png",
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )),
              _textfield(_userTextController, "Benutzername"),
              _textfield(_passwordTextController, "Passwort"),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  child: SizedBox(
                    height: 40,
                    child: OutlinedButton(
                      onPressed: () => serverloader(context, _serverTextController),
                      child: Text(
                        "Serverauswahl",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )),
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
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        border: OutlineInputBorder()),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                child: SizedBox(
                    width: 200,
                    height: 50,
                    child: OutlinedButton(
                      child: Text(
                        "Einloggen",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Colors.white)))),
                      onPressed: () {
                        Matrix.of(context)
                            .login(
                                _serverTextController.text,
                                _userTextController.text,
                                _passwordTextController.text)
                            .then((value) {
                          if (value) {
                            AppStateManager.of(context).setLoggedIn(true);
                          }
                          Navigator.pop(context);
                        });
                      },
                    )),
              )
            ],
          ),
    ));
  }

  Widget _textfield(var _TextController, var hint) => Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(5),
        child: SizedBox(
          width: 300,
          child: TextField(
            obscureText: (hint == "Passwort") ? true : false,
            controller: _TextController,
            decoration: InputDecoration(
                hintText: "$hint",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                border: OutlineInputBorder()),
          ),
        ),
      );
}
