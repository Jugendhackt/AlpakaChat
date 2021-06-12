



import 'package:alpaka_chat/views/appstate.dart';
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
        leading: IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {},
        ),
        actions: [
          IconButton(
              alignment: Alignment.centerRight,
              icon: Icon(Icons.settings),
              onPressed: () {}
          ),
          IconButton(
            alignment: Alignment.centerLeft,
            onPressed: () {
              Matrix.of(context).logout();
              AppStateManager.of(context).setLoggedIn(false);
              },
            icon: Icon(Icons.exit_to_app),
          )
        ]
      ),
      body: FutureBuilder(
        future: Matrix.of(context).client.getJoinedRooms(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text(snapshot.error.toString());
          if (!snapshot.hasData) return CircularProgressIndicator();
          return StreamBuilder(
            stream: Matrix.of(context).client.onRoomUpdate.stream,
            builder: (context, snap2) => ListView(
              children: (snapshot.data! as List<String>).map((id) {
                if (Matrix.of(context).client.getRoomById(id) == null) return Container();
                return ListTile(
                  leading: Icon(Icons.account_box),
                  title: Text(Matrix.of(context).client.getRoomById(id).displayname),
                  subtitle: Text("Letzte Nachricht von " + Matrix.of(context).client.getRoomById(id).displayname),
                  onTap: () {},
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}