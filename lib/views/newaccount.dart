import 'package:flutter/material.dart';

class registerwidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _newaccound();
}

class _newaccound extends State<registerwidget> {
  TextEditingController _usernametextcontroller = new TextEditingController();
  TextEditingController _passwordtextcontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ein neues Benutzerkonto erstellen"),
      ),
        body: Container(
            decoration: BoxDecoration(
              color: Color(0xbae3fff0),
            ),
            child: ListView(children: [
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
                        Expanded(child: Text(
                          "Ein neues Benutzerkonto erstellen",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                      ],
                    ),
                  )),

              _textfield(_usernametextcontroller, "Benutzername"),
              _textfield(_passwordtextcontroller, "Passwort"),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  child: SizedBox(
                      width: 200,
                      height: 50,
                      child: OutlinedButton(
                        child: Text(
                          "Create new",
                          style: TextStyle(fontSize: 20),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color: Colors.white)))),
                        onPressed: () {},
                      )))
            ])));
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
