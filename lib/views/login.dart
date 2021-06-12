

import 'package:flutter/material.dart';

class Loginwidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _loginwidget();
}

class _loginwidget extends State<Loginwidget>{
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text("Login", style: TextStyle(fontSize: 50), textAlign: TextAlign.center),
        SizedBox(
          width: 300,
          child: TextField(
            decoration: InputDecoration(
                hintText: "Email",
                contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                border: OutlineInputBorder()
            ),
          ),
        ),
        SizedBox(
          width: 300,
          child: TextField(
            decoration: InputDecoration(
                hintText: "Password",
                contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                border: OutlineInputBorder()
            ),
          ),
        ),
        SizedBox(
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
              onPressed: (){},
            )
        )
      ],
    );
  }
}
