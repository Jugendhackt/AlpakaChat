



import 'package:flutter/material.dart';

class Homeview extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _homeview();
}

class _homeview extends State<Homeview>{
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               IconButton(
                icon: Icon(Icons.account_circle),
                 iconSize: 50,
                 splashRadius: 30,
                onPressed: () {},
              ),
              IconButton(
                  alignment: Alignment.centerRight,
                  icon: Icon(Icons.settings),
                iconSize: 50,
                splashRadius: 30,
                onPressed: () {}
              )
            ],
          )
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Row(
                children: [
                  Container(
                    child: Icon(Icons.account_box_outlined, size: 100,),
                  ),
                  Column(
                    children: [
                      Text(
                        "Kontakt 1",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "Letzte Nachticht von Kontakt 1",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}