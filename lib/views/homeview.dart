



import 'package:flutter/material.dart';

class Homeview extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _homeview();
}

class _homeview extends State<Homeview>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deine Chats"),
      ),
      body: ListView(
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
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text("Kontakt 1"),
            subtitle: Text("Letzte Nachricht von kontakt 1"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}