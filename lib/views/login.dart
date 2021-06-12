

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
              decoration: InputDecoration(
                  hintText: "Email",
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
                  //Login daten überprüfen
                },
              )
          ),
        )
      ],
    );
  }
}
