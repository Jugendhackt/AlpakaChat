



import 'package:flutter/material.dart';

import '../matrix.dart';

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
        centerTitle: true,
        actions: [
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
        ]
      ),
      body: FutureBuilder(
        future: Matrix.of(context).client.getJoinedRooms(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text(snapshot.error.toString());
          if (!snapshot.hasData) return CircularProgressIndicator();
          return ListView(
            children: (snapshot.data! as List<String>).map((id) => ListTile(
              leading: Icon(Icons.account_box),
              title: Text(Matrix.of(context).client.getRoomById(id).displayname),
              subtitle: Text("Letzte Nachricht von " + Matrix.of(context).client.getRoomById(id).displayname),
              onTap: () {},
            )).toList(),
          );
        },
      ),
    );
  }
}